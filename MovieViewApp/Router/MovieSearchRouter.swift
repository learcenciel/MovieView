//
//  MovieSearchRouter.swift
//  MovieViewApp
//
//  Created by Alexander on 21.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation
import UIKit

class MovieSearchRouter {
    fileprivate weak var movieSearchViewController: MovieSearchViewController?
    
    init(movieSearchViewController: MovieSearchViewController) {
        self.movieSearchViewController = movieSearchViewController
    }
    
    func presentDetails(for movieId: Int) {
        
        let movieDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieDetailsViewController") as! MovieDetailsViewController
        movieDetailsViewController.movieId = movieId
        
        movieSearchViewController?.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
