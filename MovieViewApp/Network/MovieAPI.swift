//
//  MovieAPI.swift
//  MovieViewApp
//
//  Created by Alexander on 15.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

class MovieAPI {
    
    static let shared = MovieAPI()
    
    private let httpClient = HTTPClient()
    private init() {}
    
    func fetchMovies(movieType: MovieType, parameters: [String: Any]?, completionHandler: @escaping(Result<MovieListResponse, HTTPErrors>) -> ()) {
        switch movieType {
        case .topRated:
            httpClient.get(url: "https://api.themoviedb.org/3/movie/top_rated", parameters: parameters, completionHandler: completionHandler)
        case .popular:
            httpClient.get(url: "https://api.themoviedb.org/3/movie/popular", parameters: parameters, completionHandler: completionHandler)
        case .upcoming:
            httpClient.get(url: "https://api.themoviedb.org/3/movie/upcoming", parameters: parameters, completionHandler: completionHandler)
        }
    }
    
    func fetchMovieDetails(movieId: Int, parameters: [String: Any]?, completionHandler: @escaping(Result<MovieDetailInfo, HTTPErrors>) -> ()) {
        httpClient.get(url: "https://api.themoviedb.org/3/movie/\(movieId)", parameters: parameters, completionHandler: completionHandler)
    }
    
    func fetchMovieCrew(movieId: Int, parameters: [String: Any]?, completionHandler: @escaping(Result<MovieDetailCastCrewInfo, HTTPErrors>) -> ()) {
        httpClient.get(url: "https://api.themoviedb.org/3/movie/\(movieId)/credits", parameters: parameters, completionHandler: completionHandler)
    }
    
    func fetchMovieTrailer(movieId: Int, parameters: [String: Any]?, completionHandler: @escaping(Result<MovieTrailerInfo, HTTPErrors>) -> ()) {
        httpClient.get(url: "https://api.themoviedb.org/3/movie/\(movieId)/videos", parameters: parameters, completionHandler: completionHandler)
    }
}
