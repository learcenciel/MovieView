//
//  String + Extension.swift
//  MovieViewApp
//
//  Created by Alexander on 20.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

extension String {
    func formatMovieReleaseYear() -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        guard let date = dateFormatter.date(from: self) else { return "Uknown release date" }

        let calendar = Calendar.autoupdatingCurrent
        return String((calendar.dateComponents([.year], from: date).year)!)
    }
}
