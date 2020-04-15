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
    
    func getGenres(completionHandler: @escaping(GenreResponse?, TritonError?) -> ()) {
        httpClient.getGenres(completionHandler: completionHandler)
    }
    
    func getTopRatedMovies(completionHandler: @escaping(MovieListResponse?, TritonError?) -> ()) {
        httpClient.getTopRatedMovies(completionHandler: completionHandler)
    }
}
