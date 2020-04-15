//
//  ViewController.swift
//  MovieViewApp
//
//  Created by Alexander on 14.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import UIKit

class AllMovieListViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var cv: UICollectionView!
    @IBOutlet weak var blurBackgroundsMoveImageView: UIImageView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var movieNameLabelLedaingConstraint: NSLayoutConstraint!
    @IBOutlet weak var movieRatingTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topContainerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topContainerTrailingConstraint: NSLayoutConstraint!
    
    
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMock()
        
        setupCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    
    func setupMock() {
        images.append(UIImage(named: "Avengers")!)
        images.append(UIImage(named: "Avengers2")!)
        images.append(UIImage(named: "BlackWidow")!)
        images.append(UIImage(named: "Joker")!)
    }
    
    func setupInsetsConstraints(_ insetX: CGFloat) {
        movieNameLabelLedaingConstraint.constant = insetX
        movieRatingTrailingConstraint.constant = insetX
        topContainerLeadingConstraint.constant = insetX
        topContainerTrailingConstraint.constant = insetX
    }
    
    func setupCollectionView() {
        
        let cellWidthScaling: CGFloat = 0.85
        
        collectionViewHeight.constant = UIScreen.main.bounds.size.width * 4/3
        
        let collectionViewSize = UIScreen.main.bounds.size
        let cellWidth = floor(collectionViewSize.width * cellWidthScaling)
        let cellHeight = collectionViewHeight.constant * 0.95
        let insetX = (view.bounds.width - cellWidth) / 2.0
        
        setupInsetsConstraints(insetX)
        
        let layout = cv!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        cv?.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        
        cv?.dataSource = self
        cv?.delegate = self
        self.cv.decelerationRate = .fast
    }
}

extension AllMovieListViewController {
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        print(123)
    }
}

extension AllMovieListViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CustomCell
        
        cell.movieImageView.image = images[indexPath.item]
        
        return cell
    }
}

extension AllMovieListViewController : UIScrollViewDelegate, UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // Ensure the scrollview is the one on the collectionView we care are working with
        if (scrollView == self.cv) {
            
            // Find cell closest to the frame centre with reference from the targetContentOffset.
            let frameCenter: CGPoint = self.cv.center
            var targetOffsetToCenter: CGPoint = CGPoint(x: targetContentOffset.pointee.x + frameCenter.x, y: targetContentOffset.pointee.y + frameCenter.y)
            var indexPath: IndexPath? = self.cv.indexPathForItem(at: targetOffsetToCenter)
            
            // Check for "edge case" where the target will land right between cells and then next neighbor to prevent scrolling to //index {0,0}.
            while indexPath == nil {
                targetOffsetToCenter.x += 10
                indexPath = self.cv.indexPathForItem(at: targetOffsetToCenter)
            }
            // safe unwrap to make sure we found a valid index path
            if let index = indexPath {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.movieNameLabel.text = self.images[index[1]].description
                    self.blurBackgroundsMoveImageView.image = self.images[index[1]]
                }
                // Find the centre of the target cell
                if let centerCellPoint: CGPoint = cv.layoutAttributesForItem(at: index)?.center {
                    
                    // Calculate the desired scrollview offset with reference to desired target cell centre.
                    let desiredOffset: CGPoint = CGPoint(x: centerCellPoint.x - frameCenter.x, y: centerCellPoint.y - frameCenter.y)
                    targetContentOffset.pointee = desiredOffset
                }
            }
        }
    }
}

class CustomCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
}


