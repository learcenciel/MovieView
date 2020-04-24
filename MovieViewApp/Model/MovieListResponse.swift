//
//  MovieListResponse.swift
//  MovieViewApp
//
//  Created by Alexander on 15.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

struct MovieListResponse: Decodable {

    let currentPage: Int?
    let totalResultsCount: Int?
    let totalPages: Int?
    let movies: [Movie]

    private enum CodingKeys: String, CodingKey {
        case currentPage = "page"
        case totalResultsCount = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}

struct Movie: Decodable {

    let identifier: Int
    let title: String
    let releaseDate: String
    let popularity: Float
    let voteCount: Int
    let voteAverage: Float
    let hasVideo: Bool
    let posterPath: String?
    let backDropPath: String?
    let plotDescription: String

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title = "title"
        case releaseDate = "release_date"
        case popularity = "popularity"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case hasVideo = "video"
        case posterPath = "poster_path"
        case backDropPath = "backdrop_path"
        case plotDescription = "overview"
    }
}
