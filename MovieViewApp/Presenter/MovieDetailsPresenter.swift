//
//  MovieDetailsPresenter.swift
//  MovieViewApp
//
//  Created by Alexander on 20.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

protocol MovieDetailsView: class {
    func displayMovieDetails(movieDetailsInfo: MovieDetailInfo)
    func displayMovieCastCrewInfo(movieCastCrewInfo: MovieDetailCastCrewInfo)
    func displayMovieTrailer(movieTrailer: MovieTrailer)
}

class MovieDetailsPresenter {
    
    private weak var view: MovieDetailsView?
    
    private let apiService = MovieAPI.shared
    
    init(view: MovieDetailsView) {
        self.view = view
    }
    
    func viewDidLoad(movieId: Int) {
        fetchMovieDetails(movieId: movieId)
        fetchMovieCastCrew(movieId: movieId)
        fetchMovieTrailer(movieId: movieId)
    }
    
    private func fetchMovieDetails(movieId: Int) {
        apiService.fetchMovieDetails(movieId: movieId, parameters: nil) { [weak self] result in
            switch result {
            case .success(let movieDetailsResponse):
                self?.view?.displayMovieDetails(movieDetailsInfo: movieDetailsResponse)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchMovieCastCrew(movieId: Int) {
        apiService.fetchMovieCrew(movieId: movieId, parameters: nil) { result in
            switch result {
            case .success(let movieCastCrewInfo):
                self.view?.displayMovieCastCrewInfo(movieCastCrewInfo: movieCastCrewInfo)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchMovieTrailer(movieId: Int) {
        apiService.fetchMovieTrailer(movieId: movieId, parameters: nil) {result in
            switch result {
            case .success(let movieTrailer):
                guard let movieTrailer = movieTrailer.movieTrailers.first else { return }
                self.view?.displayMovieTrailer(movieTrailer: movieTrailer)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
