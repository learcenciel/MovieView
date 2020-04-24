//
//  Array + Extension.swift
//  MovieViewApp
//
//  Created by Alexander on 24.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
