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
    
    private enum CodingKeys: String, CodingKey {
        case movieCrew = "crew"
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
