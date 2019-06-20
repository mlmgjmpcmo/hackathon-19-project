//
//  BucketViewController.swift
//  PinkPoncho
//
//  Created by Jacob Mittelstaedt on 6/19/19.
//  Copyright © 2019 Jacob Mittelstaedt. All rights reserved.
//

import UIKit

class BucketViewController: UICollectionViewController {

    lazy var logoImageView: UIImageView = {
        var view = UIImageView()
        view.backgroundColor = .lightGray
//        view.image =
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    enum BucketType {
        case keep
        case maybe
        case remove
    }

    var type: BucketType? {
        didSet {
            guard let type = type else { return }
            switch type {
            case .keep:
                print("keep")
                bucketTypeImageView.image = UIImage(named: "LikeButton")
            case .maybe:
                print("maybe")
                bucketTypeImageView.image = UIImage(named: "NeutralButton")
            case .remove:
                print("remove")
                bucketTypeImageView.image = UIImage(named: "DislikeButton")
            }
        }
    }

    var bucketTypeImageView: UIImageView = {
        var view = UIImageView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var lowerLeftButton: UIButton = {
        var btn = UIButton()
        btn.backgroundColor = .blue
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    var lowerRightButton: UIButton = {
        var btn = UIButton()
        btn.backgroundColor = .green
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    init(collectionViewLayout layout: UICollectionViewLayout, bucketType: BucketType) {
        super.init(collectionViewLayout: layout)
        defer {
            self.type = bucketType
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        setSubviewConstraints()

    }

    private func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(bucketTypeImageView)
        view.addSubview(lowerLeftButton)
        view.addSubview(lowerRightButton)
    }

    private func setSubviewConstraints() {
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true

        bucketTypeImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32).isActive = true
        bucketTypeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bucketTypeImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bucketTypeImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true

        collectionView.topAnchor.constraint(equalTo: bucketTypeImageView.bottomAnchor, constant: 32).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        lowerLeftButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 32).isActive = true
        lowerLeftButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.bounds.width/5).isActive = true
        lowerLeftButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        lowerLeftButton.heightAnchor.constraint(equalToConstant: 120).isActive = true
        lowerLeftButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        
        lowerRightButton.topAnchor.constraint(equalTo: lowerLeftButton.topAnchor).isActive = true
        lowerRightButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.bounds.width/5).isActive = true
        lowerRightButton.widthAnchor.constraint(equalTo: lowerLeftButton.widthAnchor, multiplier: 1).isActive = true
        lowerRightButton.heightAnchor.constraint(equalTo: lowerLeftButton.heightAnchor, multiplier: 1).isActive = true
        lowerRightButton.bottomAnchor.constraint(equalTo: lowerLeftButton.bottomAnchor).isActive = true

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }


}
