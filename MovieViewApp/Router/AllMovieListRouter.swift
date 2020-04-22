//
//  AllMovieListPresenter.swift
//  MovieViewApp
//
//  Created by Alexander on 17.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation
import UIKit

class AllMovieListRouter {
    fileprivate weak var allMovieListViewController: AllMovieListViewController?
    
    init(allMovieListViewController: AllMovieListViewController) {
        self.allMovieListViewController = allMovieListViewController
    }
    
    func presentDetails(for movie: MovieDetailInfo) {
        let movieDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieDetailsViewController")
        
        allMovieListViewController?.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
