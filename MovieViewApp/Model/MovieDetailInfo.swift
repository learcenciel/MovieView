//
//  MovieDetailInfo.swift
//  MovieViewApp
//
//  Created by Alexander on 17.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

struct MovieDetailInfo: Decodable {
    let movieId: Int
    let movieTitle: String
    let movieReleaseDate: String
    let movieVoteAverage: Float
    let movieHasVideo: Bool
    let moviePosterPath: String?
    let movieBackDropPath: String
    let moviePlotDescription: String
    let movieGenre: [MovieGenre]
    let movieRuntime: Int
    
    private enum CodingKeys: String, CodingKey {
        case movieId = "id"
        case movieTitle = "title"
        case movieReleaseDate = "release_date"
        case movieVoteAverage = "vote_average"
        case movieHasVideo = "video"
        case moviePosterPath = "poster_path"
        case movieBackDropPath = "backdrop_path"
        case moviePlotDescription = "overview"
        case movieGenre = "genres"
        case movieRuntime = "runtime"
    }
}

struct MovieGenre: Decodable {
    let genreId: Int
    let genreName: String
    
    private enum CodingKeys: String, CodingKey {
        case genreId = "id"
        case genreName = "name"
    }
}
