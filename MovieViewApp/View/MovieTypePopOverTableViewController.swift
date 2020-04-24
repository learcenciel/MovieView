//
//  MovieTypePopOverTableViewController.swift
//  MovieViewApp
//
//  Created by Alexander on 16.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class MovieTypePopOverViewController: UIViewController {

    @IBOutlet weak var popOverTableView: UITableView!
    var movieMenuItemTapped: ((MovieType) -> Void)?

    let movieTypes = [MovieType.topRated.rawValue, MovieType.upcoming.rawValue, MovieType.popular.rawValue]

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        preferredContentSize = CGSize(width: 250, height: popOverTableView.contentSize.height)
    }
}

extension MovieTypePopOverViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)

        cell.textLabel?.text = movieTypes[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieMenuItemTapped?(MovieType.allCases[indexPath.row])
    }
}
