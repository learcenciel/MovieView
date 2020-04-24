//
//  MovieTrailerInfo.swift
//  MovieViewApp
//
//  Created by Alexander on 20.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

struct MovieTrailerInfo: Decodable {
    let movieTrailers: [MovieTrailer]

    private enum CodingKeys: String, CodingKey {
        case movieTrailers = "results"
    }
}

struct MovieTrailer: Decodable {
    let youtubeVideoId: String

    private enum CodingKeys: String, CodingKey {
        case youtubeVideoId = "key"
    }
}
