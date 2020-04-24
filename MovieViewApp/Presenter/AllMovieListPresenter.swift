//
//  AllMovieListPresenter.swift
//  MovieViewApp
//
//  Created by Alexander on 17.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

enum MovieType: String, CaseIterable {
    case topRated = "Top Rated"
    case upcoming = "Upcoming"
    case popular = "Popular"
}

protocol AllMoviesView: class {
    func displayMovies(movies: [Movie])
    func displayMoreMovies(movies: [Movie])
}

protocol MovieCellView: class {
    func displayMovieInfo(movie: Movie)
}

class AllMovieListPresenter {

    private weak var view: AllMoviesView?

    private let router: AllMovieListRouter
    private let apiService = MovieAPI.shared

    init(view: AllMoviesView,
         router: AllMovieListRouter) {
        self.view = view
        self.router = router
    }

    func viewDidLoad() {
        fetchMovies(movieType: .topRated)
    }

    func movieMenuItemTapped(movieType: MovieType) {
        fetchMovies(movieType: movieType)
    }

    func fetchNextMovies(movieType: MovieType, page: Int) {

        let parameters: [String: Any]? = ["page": page]

        apiService.fetchMovies(movieType: movieType, parameters: parameters) { [weak self] result in
            switch result {
            case .success(let movieListResponse):
                self?.view?.displayMoreMovies(movies: movieListResponse.movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func fetchMovies(movieType: MovieType) {

        apiService.fetchMovies(movieType: movieType, parameters: nil) { [weak self] result in
            switch result {
            case .success(let movieListResponse):
                self?.view?.displayMovies(movies: movieListResponse.movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
