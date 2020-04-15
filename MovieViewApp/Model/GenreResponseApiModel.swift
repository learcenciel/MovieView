//
//  GenreResponseApiModel.swift
//  MovieViewApp
//
//  Created by Alexander on 15.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

struct GenreResponse: Decodable {
    let movieGenres: [MovieGenre]
    
    private enum CodingKeys: String, CodingKey {
        case movieGenres = "genres"
    }
}

struct MovieGenre: Decodable {
    let movieGenreId: Int
    let movieGenreName: String
    
    private enum CodingKeys: String, CodingKey {
        case movieGenreId = "id"
        case movieGenreName = "name"
    }
}
