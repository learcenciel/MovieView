//
//  MovieListResponse.swift
//  MovieViewApp
//
//  Created by Alexander on 15.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

struct MovieListResponse: Decodable {
    let currentPage: Int
    let totalResultsCount: Int
    let totalPages: Int
    let movieInfo: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case currentPage = "page"
        case totalResultsCount = "total_results"
        case totalPages = "total_pages"
        case movieInfo = "results"
    }
}

struct Movie: Decodable {
    let movieId: Int
    let movieTitle: String
    let movieReleaseDate: String
    let moviePopularity: Float
    let movieVoteCount: Int
    let movieVoteAverage: Float
    let movieHasVideo: Bool
    let moviePosterPath: String
    let movieBackDropPath: String
    let moviePlotDescription: String
    //let movieGenre: [Int]
    
    private enum CodingKeys: String, CodingKey {
        case movieId = "id"
        case movieTitle = "title"
        case movieReleaseDate = "release_date"
        case moviePopularity = "popularity"
        case movieVoteCount = "vote_count"
        case movieVoteAverage = "vote_average"
        case movieHasVideo = "video"
        case moviePosterPath = "poster_path"
        case movieBackDropPath = "backdrop_path"
        case moviePlotDescription = "overview"
    }
}
