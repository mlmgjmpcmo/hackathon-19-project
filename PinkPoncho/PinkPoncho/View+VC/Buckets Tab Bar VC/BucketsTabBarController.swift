//
//  BucketsTabBarController.swift
//  PinkPoncho
//
//  Created by Jacob Mittelstaedt on 6/19/19.
//  Copyright © 2019 Jacob Mittelstaedt. All rights reserved.
//

import UIKit

class BucketsTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([BucketViewController(collectionViewLayout: UICollectionViewFlowLayout(), bucketType: .keep),
                            BucketViewController(collectionViewLayout: UICollectionViewFlowLayout(), bucketType: .maybe),
                            BucketViewController(collectionViewLayout: UICollectionViewFlowLayout(), bucketType: .remove)],
                           animated: false)

        for item in tabBar.items! {
            item.title = "Yas"
        }
    }

}
