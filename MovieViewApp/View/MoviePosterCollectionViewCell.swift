//
//  CustomCell.swift
//  MovieViewApp
//
//  Created by Alexander on 22.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class MoviePosterCollectioNViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!

    func setup(movie: Movie) {
        guard
            let posterPath = movie.posterPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
        else { return }

        movieImageView.kf.setImage(with: url)
    }
}
