//
//  MovieDetailsViewController.swift
//  MovieViewApp
//
//  Created by Alexander on 17.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import AVFoundation
import UIKit
import youtube_ios_player_helper

class MovieDetailsViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    @IBOutlet weak var movieInfoNavigationSectionView: UIView!
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var backgroundMoviePosterImageView: UIImageView!
    
    @IBOutlet weak var directorNameLabel: UILabel!
    @IBOutlet weak var producerNameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieGenresLabel: UILabel!
    
    @IBOutlet weak var movieTrailerPlayerView: YTPlayerView!
    
    @IBOutlet weak var movieCastCollectionView: UICollectionView!
    @IBOutlet weak var movieCastCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollContentHeight: UIView!
    
    var movieId: Int!
    var movieCast: [MovieCast] = []
    var movieCastProfileImages: MovieCastProfile!
    
    lazy var presenter: MovieDetailsPresenter = {
        return MovieDetailsPresenter(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(movieId: self.movieId)
        setupCollectionView()
    }
    
    func setupNavigationSection() {
        
        movieInfoNavigationSectionView.backgroundColor = UIColor(white: 0, alpha: 0.6)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .black
        
        let yourBackImage = UIImage(named: "back_icon")
        
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationBar.backItem?.title = "Back"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func setupMovieTrailerPlayer(movieTrailerId: String) {
        let params: [String: Int] = ["playsinline": 1]
        
        self.movieTrailerPlayerView.load(withVideoId: movieTrailerId, playerVars: params)
    }
    
    func setupCollectionView() {
        guard
            let flowLayout = movieCastCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        else { return }
        flowLayout.sectionInset = .zero
        flowLayout.minimumInteritemSpacing = 10
        let size = Int(movieCastCollectionView.bounds.width / 6)
        flowLayout.itemSize = CGSize(width: size, height: size)
        movieCastCollectionViewHeight.constant = CGFloat(size + 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationSection()
        setupCollectionView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension MovieDetailsViewController: MovieDetailsView {
    
    func displayMovieTrailer(movieTrailer: MovieTrailer) {
        setupMovieTrailerPlayer(movieTrailerId: movieTrailer.youtubeVideoId)
    }
    
    func displayMovieCastCrewInfo(movieCastCrewInfo: MovieDetailCastCrewInfo) {
        self.movieCast = movieCastCrewInfo.movieCast
        self.movieCastCollectionView.reloadData()
        self.directorNameLabel.text = movieCastCrewInfo.movieCrew.first(where: { movieCrewMember in
            movieCrewMember.memberJob == "Director"
        })?.memberName
        self.producerNameLabel.text = movieCastCrewInfo.movieCrew.first(where: { movieCrewMember in
            movieCrewMember.memberJob == "Executive Producer" || movieCrewMember.memberJob == "Co-Executive Producer"
                || movieCrewMember.memberJob == "Director"
        })?.memberName
    }
    
    func displayMovieDetails(movieDetailsInfo: MovieDetailInfo) {
        self.movieGenresLabel.text = ""
        self.movieGenresLabel.text = movieDetailsInfo.movieGenre.compactMap { $0.genreName }.joined(separator: ", ")
        self.durationLabel.text = movieDetailsInfo.movieRuntime.durationFormatt()
        
        guard
            let moviePosterPath = movieDetailsInfo.moviePosterPath,
            let moviePosterPathUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(moviePosterPath)")
            else { return }
        self.backgroundMoviePosterImageView.kf.setImage(with: moviePosterPathUrl)
        self.moviePosterImageView.kf.setImage(with: moviePosterPathUrl)
        
        self.movieNameLabel.text = movieDetailsInfo.movieTitle
        self.movieReleaseYearLabel.text = "(" + movieDetailsInfo.movieReleaseDate.formatMovieReleaseYear() + ")"
        self.movieOverviewLabel.text = movieDetailsInfo.moviePlotDescription
    }
}

extension MovieDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MovieCastCollectionViewCell
        let personId = self.movieCast[indexPath.row].actorId
        presenter.cellSetup(cell: cell, personId: personId)
        return cell
    }
}
