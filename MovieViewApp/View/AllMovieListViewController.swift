//
//  ViewController.swift
//  MovieViewApp
//
//  Created by Alexander on 14.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Kingfisher
import UIKit

class AllMovieListViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var moviesTypeLabel: UILabel!

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var blurBackgroundsMoveImageView: UIImageView!
    @IBOutlet weak var transitionBlurBackgroundsMoveImageView: UIImageView!

    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!

    @IBOutlet weak var movieNameLabelLedaingConstraint: NSLayoutConstraint!
    @IBOutlet weak var movieRatingTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topContainerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topContainerTrailingConstraint: NSLayoutConstraint!

    lazy var presenter: AllMovieListPresenter = {
        return AllMovieListPresenter(view: self, router: AllMovieListRouter(allMovieListViewController: self))
    }()

    private var movies: [Movie] = []
    var page = 1
    var loading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter.viewDidLoad()
    }

    @IBAction func movieTypeMenuTaped(_ sender: UITapGestureRecognizer) {
        guard
            let popVC = storyboard?.instantiateViewController(identifier: "popVC") as? MovieTypePopOverViewController
        else { return }

        popVC.modalPresentationStyle = .popover

        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = sender.view
        popOverVC?.sourceRect = CGRect(x: sender.location(in: sender.view).x,
                                       y: sender.location(in: sender.view).y,
                                       width: 0,
                                       height: 0)

        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        popVC.movieMenuItemTapped = { movieType in
            self.moviesTypeLabel.text = movieType.rawValue
            self.presenter.movieMenuItemTapped(movieType: movieType)
            popVC.dismiss(animated: true, completion: nil)
        }
        self.present(popVC, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    func setupInsetsConstraints(_ insetX: CGFloat) {
        movieNameLabelLedaingConstraint.constant = insetX
        movieRatingTrailingConstraint.constant = insetX
        topContainerLeadingConstraint.constant = insetX
        topContainerTrailingConstraint.constant = insetX
    }

    func setupCollectionView() {

        collectionViewHeight.constant = UIScreen.main.bounds.size.width * 4/3

        let collectionViewSize = UIScreen.main.bounds.size
        let cellWidth = floor(collectionViewSize.width * 0.85)
        let cellHeight = collectionViewHeight.constant * 0.95
        let insetX = (view.bounds.width - cellWidth) / 2.0

        setupInsetsConstraints(insetX)

        let layout = moviesCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: cellWidth, height: cellHeight)

        moviesCollectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        moviesCollectionView.decelerationRate = .fast
    }
}

extension AllMovieListViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension AllMovieListViewController {
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        guard let movieSearchViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieSearchViewController") as? MovieSearchViewController
        else { return }

        self.navigationController?.pushViewController(movieSearchViewController, animated: true)
    }
}

extension AllMovieListViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.item == self.movies.count - 1 {
            self.page += 1
            guard let movieTypeText = self.moviesTypeLabel.text else { fatalError() }
            guard let movieType = MovieType(rawValue: movieTypeText) else { fatalError() }
            loading = true
            presenter.fetchNextMovies(movieType: movieType, page: self.page)
        }

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId",
                                                            for: indexPath) as? MoviePosterCollectioNViewCell
        else { fatalError() }
        cell.setup(movie: self.movies[indexPath.row])
        return cell
    }
}

extension AllMovieListViewController: UIScrollViewDelegate, UICollectionViewDelegate {

    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard scrollView === self.moviesCollectionView else { return }

        let frameCenter: CGPoint = self.moviesCollectionView.center
        var targetOffsetToCenter: CGPoint = CGPoint(x: targetContentOffset.pointee.x + frameCenter.x,
                                                    y: targetContentOffset.pointee.y + frameCenter.y)
        var indexPath: IndexPath? = self.moviesCollectionView.indexPathForItem(at: targetOffsetToCenter)
        while indexPath == nil {
            targetOffsetToCenter.x += 10
            indexPath = self.moviesCollectionView.indexPathForItem(at: targetOffsetToCenter)
        }

        if let index = indexPath {
            if let centerCellPoint: CGPoint = moviesCollectionView.layoutAttributesForItem(at: index)?.center {
                let desiredOffset: CGPoint = CGPoint(x: centerCellPoint.x - frameCenter.x,
                                                     y: centerCellPoint.y - frameCenter.y)
                targetContentOffset.pointee = desiredOffset
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView === self.moviesCollectionView,
            let indexPath = moviesCollectionView.indexPathForItem(at: view.convert(view.center,
                                                                                   to: moviesCollectionView)),
            let movie = self.movies[safe: indexPath.item]
        else { return }
        configureMovieInfo(movie: movie)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let movieDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController
        else { return }

        movieDetailsViewController.movieId = self.movies[indexPath.row].identifier

        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}

extension AllMovieListViewController: AllMoviesView {
    func displayMoreMovies(movies: [Movie]) {
        self.movies += movies
        moviesCollectionView.reloadData()
        loading = false
    }

    func displayMovies(movies: [Movie]) {
        self.movies = movies
        moviesCollectionView.reloadData()

        if let movie = movies.first {
            moviesCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
            configureMovieInfo(movie: movie)

            guard
                let posterPath = movie.posterPath,
                let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
                else { return }
            self.transitionBlurBackgroundsMoveImageView.kf.setImage(with: url)
        }
    }

    func configureMovieInfo(movie: Movie) {
        self.movieNameLabel.text = movie.title
        self.movieReleaseDateLabel.text = movie.releaseDate
        self.movieRatingLabel.text = "\(movie.voteAverage)/10"
        self.movieDescriptionLabel.text = movie.plotDescription

        guard
            let posterPath = movie.posterPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
        else { return }

        self.blurBackgroundsMoveImageView.kf.setImage(with: url)

        UIView.animate(withDuration: 0.3, animations: {
            self.transitionBlurBackgroundsMoveImageView.alpha = 0.0
        }) { _ in
            self.transitionBlurBackgroundsMoveImageView.kf.setImage(with: url)
            self.transitionBlurBackgroundsMoveImageView.alpha = 1.0
        }
    }
}
