//
//  Int + Extension.swift
//  MovieViewApp
//
//  Created by Alexander on 20.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

extension Int {
    func durationFormatt() -> String {
        let hours = Int(self / 60)
        let minutes: UInt = UInt(self - hours * 60)
        return "\(hours)hr \(minutes)min"
    }
}
