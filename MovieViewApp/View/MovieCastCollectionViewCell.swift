//
//  asd.swift
//  MovieViewApp
//
//  Created by Alexander on 22.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class MovieCastCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var actorThumbnailImageview: UIImageView!

    override func awakeFromNib() {
        layer.cornerRadius = min(frame.size.height, frame.size.width) / 2.0
        layer.masksToBounds = true
    }
}

extension MovieCastCollectionViewCell: MovieCastInfoCell {
    func displayMovieCastProfileImages(movieCastProfileImages: MovieCastProfileImagesInfo) {
        guard let movieCastProfile = movieCastProfileImages.castProfile.first else { return }
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + (movieCastProfile?.profileImagePath)!)

        actorThumbnailImageview.kf.setImage(with: url)
    }
}
