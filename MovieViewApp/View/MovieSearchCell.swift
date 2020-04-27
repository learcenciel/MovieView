//
//  MovieSearchCell.swift
//  MovieViewApp
//
//  Created by Alexander on 27.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation
import UIKit

class MovieSearchCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var posterContainer: UIView!
    
    override func prepareForReuse() {
        movieTitleLabel.text = ""
        moviePosterImageView.image = nil
        movieOverviewLabel.text = ""
        movieReleaseDateLabel.text = ""
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        moviePosterImageView.clipsToBounds = true
        posterContainer.layer.shadowOffset = .zero
        posterContainer.layer.shadowColor = UIColor.black.cgColor
        posterContainer.layer.shadowRadius = 5
        posterContainer.layer.shadowOpacity = 1
        posterContainer.clipsToBounds = false
    }

    func setup(movie: Movie) {

        movieOverviewLabel.text = movie.plotDescription

        if let posterPath = movie.posterPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            moviePosterImageView.kf.setImage(with: url)
        }

        if movie.releaseDate == "" {
            movieReleaseDateLabel.text = "Upcoming soon"
        } else {
            movieReleaseDateLabel.text = movie.releaseDate
        }

        movieTitleLabel.text = movie.title
    }
}
