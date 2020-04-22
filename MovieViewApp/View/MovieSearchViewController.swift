//
//  MovieSearchViewController.swift
//  MovieViewApp
//
//  Created by Alexander on 21.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class MovieSearchCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    
    func setup(movie: Movie) {
        
        if let posterPath = movie.posterPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            moviePosterImageView.kf.setImage(with: url)
        }
        
        if movie.releaseDate == "" {
            movieReleaseDateLabel.text = "Upcoming soon"
        } else {
            movieReleaseDateLabel.text = movie.releaseDate
        }
        
        movieTitleLabel.text = movie.title
    }
}

class MovieSearchViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var movieSearchTextField: UITextField!
    @IBOutlet weak var searchedMoviesTableView: UITableView!
    
    var movies: [Movie?] = []
    
    lazy var presenter: MovieSearchPresenter = {
        return MovieSearchPresenter(view: self, router: MovieSearchRouter(movieSearchViewController: self))
    }()
    
    func setupTextField() {
        
        let clearButtonRect = CGRect(x: 0, y: 0, width: movieSearchTextField.bounds.height * 0.6, height: movieSearchTextField.bounds.height * 0.6)
        
        let clearButtonTextField = UIButton(frame: clearButtonRect)
        
        let rightView = UIView(frame: CGRect(
            x: 0, y: 0,
            width: clearButtonTextField.frame.width + 10,
            height: clearButtonTextField.frame.height))
        rightView.addSubview(clearButtonTextField)
        
        clearButtonTextField.setImage(UIImage(named: "clear_icon"), for: .normal)
        clearButtonTextField.addTarget(self, action: #selector(clearMovieSearchTextField), for: .touchUpInside)
        
        movieSearchTextField.rightView = rightView
        movieSearchTextField.rightViewMode = .whileEditing
        movieSearchTextField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        let yourBackImage = UIImage(named: "back_icon")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationBar.backItem?.title = "Back"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func clearMovieSearchTextField() {
        self.movieSearchTextField.text = ""
    }
}

extension MovieSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieSearchCell", for: indexPath) as! MovieSearchCell
        
        guard let movie = self.movies[indexPath.row] else { fatalError() }
        
        cell.setup(movie: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieId = self.movies[indexPath.row]?.id else { return }
        presenter.searchedMovieTapped(movieId: movieId)
    }
}

extension MovieSearchViewController: MovieSearchView {
    func displaySearchedMovies(movies: [Movie]) {
        self.movies = movies
        self.searchedMoviesTableView.reloadData()
    }
    
    func displayMoreSearchedMovies(movies: [Movie]) {
        
    }
}

extension MovieSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let movieTitle = textField.text else { return true }
        presenter.movieSearched(movieTitle: movieTitle)
        return true
    }
}
