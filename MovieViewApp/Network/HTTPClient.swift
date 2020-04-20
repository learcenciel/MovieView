//
//  HTTPClient.swift
//  MovieViewApp
//
//  Created by Alexander on 15.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Alamofire
import Foundation

enum HTTPErrors: Error {
    case parsingError
}

class HTTPClient {
    
    static let apiV3AuthKey = "ade32b46fe48b68efe2461663d304fca"
    
    static var parameters: [String: Any] = [
        "api_key": HTTPClient.apiV3AuthKey,
        "language": "en-US",
        "region": "US"
    ]
    
    func get<T: Decodable>(url: String, parameters: [String: Any]?, completionHandler: @escaping(Result<T, HTTPErrors>) -> ()) {
        
        if let parameters = parameters {
            for key in parameters.keys {
                HTTPClient.parameters[key] = parameters[key]
            }
        }
        
        AF.request(url, method: .get, parameters: HTTPClient.parameters).validate().responseData { data in
            switch data.result {
            case .success(let responseData):
                do {
                    let jsonDecoder = JSONDecoder()
                    let decodedResponseData = try jsonDecoder.decode(T.self, from: responseData)
                    completionHandler(.success(decodedResponseData))
                } catch {
                    completionHandler(.failure(.parsingError))
                }
            case .failure:
                completionHandler(.failure(.parsingError))
            }
        }
    }
}
