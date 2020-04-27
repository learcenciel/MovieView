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
    
    override func layoutSubviews() {
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
    func setup(movie: Movie) {
        guard
            let posterPath = movie.posterPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
        else { return }

        movieImageView.kf.setImage(with: url)
    }
}
