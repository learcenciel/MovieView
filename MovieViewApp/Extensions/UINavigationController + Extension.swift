//
//  UINavigationController + Extension.swift
//  MovieViewApp
//
//  Created by Alexander on 20.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
}
