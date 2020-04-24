//
//  MovieSearchPresenter.swift
//  MovieViewApp
//
//  Created by Alexander on 21.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

protocol MovieSearchView: class {
    func displaySearchedMovies(movies: [Movie])
    func displayMoreSearchedMovies(movies: [Movie])
}

protocol MovieSearchedCellView: class {
    func displaySearchedMovieInfo(movie: Movie)
}

class MovieSearchPresenter {

    private weak var view: MovieSearchView?
    private weak var cellView: MovieSearchedCellView?

    private let router: MovieSearchRouter
    private let apiService = MovieAPI.shared

    init(view: MovieSearchView,
         router: MovieSearchRouter) {
        self.view = view
        self.router = router
    }

    func movieSearched(movieTitle: String) {
        fetchSearchedMovies(titleStartsWith: movieTitle)
    }

    func searchedMovieTapped(movieId: Int) {
        router.presentDetails(for: movieId)
    }

    func fetchSearchedMovies(titleStartsWith title: String) {

        let parameters: [String: Any]? = ["page": 1, "query": title]

        apiService.fetchMovies(by: title, parameters: parameters) { [weak self] result in
            switch result {
            case .success(let searchedMovieListResponse):
                self?.view?.displaySearchedMovies(movies: searchedMovieListResponse.movies)
            case .failure(let err):
                print(err)
            }
        }
    }

    func fetchNextSearchedMovies(titleStartsWith title: String, page: Int) {

        let parameters: [String: Any]? = ["page": page, "query": title]

        apiService.fetchMovies(by: title, parameters: parameters) { [weak self] result in
            switch result {
            case .success(let searchedMovieListResponse):
                self?.view?.displayMoreSearchedMovies(movies: searchedMovieListResponse.movies)
            case .failure(let err):
                print(err)
            }
        }
    }
}
