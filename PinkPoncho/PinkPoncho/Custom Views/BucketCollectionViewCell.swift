//
//  BucketCollectionViewCell.swift
//  PinkPoncho
//
//  Created by Jacob Mittelstaedt on 6/20/19.
//  Copyright © 2019 Jacob Mittelstaedt. All rights reserved.
//

import UIKit

class BucketCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView = {
        var view = UIImageView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var didSelectImageView: UIImageView = {
        var view = UIImageView()
        view.image = #imageLiteral(resourceName: "Deselect")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var didSelect: Bool = false {
        didSet {
            if didSelect {
                 didSelectImageView.image = #imageLiteral(resourceName: "Select")
            } else {
                 didSelectImageView.image = #imageLiteral(resourceName: "Deselect")
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)
        addSubview(didSelectImageView)
        setSubviewConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setSubviewConstraints() {
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        didSelectImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        didSelectImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        didSelectImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        didSelectImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
    }

}
