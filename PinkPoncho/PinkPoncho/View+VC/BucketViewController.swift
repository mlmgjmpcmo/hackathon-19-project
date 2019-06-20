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
        view.image = #imageLiteral(resourceName: "PinkPoncho Name")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var type: CardViewController.BucketType? {
        didSet {
            guard let type = type else { return }
            switch type {
            case .keep:
                bucketTypeImageView.image = #imageLiteral(resourceName: "LikeButton")
            case .maybe:
                bucketTypeImageView.image = #imageLiteral(resourceName: "NeutralButton")
            case .remove:
                bucketTypeImageView.image = #imageLiteral(resourceName: "DislikeButton")
            }
        }
    }

    var bucketTypeImageView: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var selectAllButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(selectAllCells(_:)), for: .touchUpInside)
        btn.setTitle("Select All", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    var lowerLeftButton: UIButton = {
        var btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "TrashcanButton"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    var lowerRightButton: UIButton = {
        var btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "DownloadButton"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    init(collectionViewLayout layout: UICollectionViewLayout, bucketType: CardViewController.BucketType) {
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
        collectionView.register(BucketCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        setSubviewConstraints()

    }

    private func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(bucketTypeImageView)
        view.addSubview(selectAllButton)
        view.addSubview(lowerLeftButton)
        view.addSubview(lowerRightButton)
    }

    private(set) var selectedAll = false

    @objc private func selectAllCells(_ sender: UIButton) {
        print("selected")
        let cellState: Bool!
        if selectedAll {
            cellState = false
        } else {
            cellState = true
        }
        selectedAll.toggle()
        for cell in collectionView.visibleCells as! [BucketCollectionViewCell] {
            cell.didSelect = cellState
        }
    }

    private func setSubviewConstraints() {
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        bucketTypeImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32).isActive = true
        bucketTypeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bucketTypeImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bucketTypeImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true

        selectAllButton.topAnchor.constraint(equalTo: bucketTypeImageView.topAnchor).isActive = true
        selectAllButton.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: -16).isActive = true
        selectAllButton.heightAnchor.constraint(equalToConstant: 30).isActive = true

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BucketCollectionViewCell
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! BucketCollectionViewCell
        cell.didSelect.toggle()
        selectedAll = false
    }

}

extension BucketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
