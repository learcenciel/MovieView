//
//  AllMovieListPresenter.swift
//  MovieViewApp
//
//  Created by Alexander on 17.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

class AllMovieListRouter {
    fileprivate weak var allMovieListViewController: AllMovieListViewController?
    fileprivate weak var movieDetailsViewController: MovieDetailsViewController?
    
    init(allMovieListViewController: AllMovieListViewController) {
        self.allMovieListViewController = allMovieListViewController
    }
    
    func presentDetails(for movie: MovieDetailInfo) {
        guard let movieDetailsViewController = self.movieDetailsViewController else { return }
        allMovieListViewController?.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
