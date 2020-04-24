//
//  AppDelegate.swift
//  MovieViewApp
//
//  Created by Alexander on 14.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

// swiftlint:disable all

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        guard
            let rootNavigationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootNavigationController") as? UINavigationController
            else { return false }

        guard
            let allMovieListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AllMovieListViewController") as? AllMovieListViewController
            else { return false }

        rootNavigationViewController.setViewControllers([allMovieListViewController], animated: false)

        window?.rootViewController = rootNavigationViewController
        window?.makeKeyAndVisible()

        return true
    }
}
