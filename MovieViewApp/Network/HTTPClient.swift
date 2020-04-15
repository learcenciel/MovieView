//
//  HTTPClient.swift
//  MovieViewApp
//
//  Created by Alexander on 15.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Alamofire
import Foundation

enum TritonError: Error {
    case parsingError
}

class HTTPClient {
    
    var request: Request?
    
    static let apiV3AuthKey = "ade32b46fe48b68efe2461663d304fca"
    
    func getGenres(completionHandler: @escaping((GenreResponse?, TritonError?) -> ())) {
        let url = "https://api.themoviedb.org/3/genre/movie/list"
        
        let parameters: Parameters = [
            "api_key": HTTPClient.apiV3AuthKey,
            "language": "en-US"
        ]
        
        AF.request(url, method: .get, parameters: parameters).validate().responseData { data in
            
            switch data.result {
            case .success(let responseData):
                do {
                    let jsonDecoder = JSONDecoder()
                    let decodedResponseData = try jsonDecoder.decode(GenreResponse.self, from: responseData)
                    completionHandler(decodedResponseData, nil)
                } catch {
                    completionHandler(nil, .parsingError)
                }
            case .failure:
                completionHandler(nil, .parsingError)
            }
        }
    }
    
    func getTopRatedMovies(completionHandler: @escaping((MovieListResponse?, TritonError?) -> ())) {
        
        let url = "https://api.themoviedb.org/3/movie/top_rated"
        
        let parameters: Parameters = [
            "api_key": HTTPClient.apiV3AuthKey,
            "language": "en-US",
            "region": "US"
        ]
        
        AF.request(url, method: .get, parameters: parameters).validate().responseData { data in
            
            switch data.result {
            case .success(let responseData):
                do {
                    let jsonDecoder = JSONDecoder()
                    let decodedResponseData = try jsonDecoder.decode(MovieListResponse.self, from: responseData)
                    completionHandler(decodedResponseData, nil)
                } catch {
                    completionHandler(nil, .parsingError)
                }
            case .failure:
                completionHandler(nil, .parsingError)
            }
        }
    }
}
