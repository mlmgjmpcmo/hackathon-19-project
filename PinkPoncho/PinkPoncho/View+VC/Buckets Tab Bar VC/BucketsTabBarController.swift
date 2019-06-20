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
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        setViewControllers([BucketViewController(collectionViewLayout: layout, bucketType: .keep),
                            BucketViewController(collectionViewLayout: layout, bucketType: .maybe),
                            BucketViewController(collectionViewLayout: layout, bucketType: .remove)],
                           animated: false)

        let tabBarTitles = ["Yes", "Maybe", "Remove"]
        for (i,item) in tabBar.items!.enumerated() {
            item.title = tabBarTitles[i]
        }
    }

}
