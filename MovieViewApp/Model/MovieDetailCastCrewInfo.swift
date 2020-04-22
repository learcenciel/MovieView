//
//  MovieDetailCastCrewInfo.swift
//  MovieViewApp
//
//  Created by Alexander on 19.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

struct MovieDetailCastCrewInfo: Decodable {
    let movieCrew: [MovieCrew]
    let movieCast: [MovieCast]
    
    private enum CodingKeys: String, CodingKey {
        case movieCrew = "crew"
        case movieCast = "cast"
    }
}

struct MovieCrew: Decodable {
    let memberName: String
    let memberJob: String
    
    private enum CodingKeys: String, CodingKey {
        case memberName = "name"
        case memberJob = "job"
    }
}

struct MovieCast: Decodable {
    let actorName: String
    let actorId: Int
    
    private enum CodingKeys: String, CodingKey {
        case actorName = "name"
        case actorId = "id"
    }
}

struct MovieCastProfileImagesInfo: Decodable {
    let castProfile: [MovieCastProfile?]
    
    private enum CodingKeys: String, CodingKey {
        case castProfile = "profiles"
    }
}

struct MovieCastProfile: Decodable {
    let profileImagePath: String
    let profileImageWidth: Int
    let profileImageHeight: Int
    
    private enum CodingKeys: String, CodingKey {
        case profileImagePath = "file_path"
        case profileImageWidth = "width"
        case profileImageHeight = "height"
    }
}
