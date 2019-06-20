//
//  CardViewController.swift
//  PinkPoncho
//
//  Created by Jacob Mittelstaedt on 6/19/19.
//  Copyright © 2019 Jacob Mittelstaedt. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var cardsSuperView: UIView!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var nextCardImageView: UIImageView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var fileDescriptionLabel: UILabel!

    var horizontalDivisor: CGFloat!
    var verticalDivisor: CGFloat!
    var pfImageOriginalCenter: CGPoint!
    var index = 0
    let colors: [UIColor] = [.black, .red, .orange, .black]

    enum BucketType {
        case keep
        case maybe
        case remove
    }

    typealias BucketCollection = (keep: [BucketImage], maybe: [BucketImage], remove: [BucketImage])
    typealias BucketImage = (image: UIImage, bucket: BucketType)

    var keepBucket: [BucketImage] = []
    var maybeBucket: [BucketImage] = []
    var removeBucket: [BucketImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        horizontalDivisor = (view.frame.width / 2) / 0.61
        verticalDivisor = (view.frame.height / 2) / 0.61
        setSubviewProperties()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pfImageOriginalCenter = cardImageView.center
    }

    private func setSubviewProperties() {
        fileDescriptionLabel.text =
        """
        Hello world!
        this is my multiline string literal
        very long
        many lines
        """

        nextCardImageView.alpha = 0
        
    }

    @IBAction func didRequestToDownload(_ sender: UIButton) {
    }

    enum SwipeDirection {
        case horizontal, vertical
    }
    var upOrLow = false
    var direction: SwipeDirection?
    @IBAction func didSwipeImage(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let translation = sender.translation(in: view)
        let xFromCenter = cardImageView.center.x - pfImageOriginalCenter.x
        let yFromCenter = cardImageView.center.y - pfImageOriginalCenter.y
        if sender.state == .began {
            if location.y <= 284 {
                upOrLow = true
            } else {
                upOrLow = false
            }
//            pfImageOriginalCenter = cardImageView.center
        } else if sender.state == .changed {
//            print(translation.x, translation.y)
            if direction == .vertical || abs(translation.y) > abs(translation.x) {
                direction = .vertical
                if translation.y < 0 {
                    cardImageView.center = CGPoint(x: pfImageOriginalCenter.x, y: pfImageOriginalCenter.y + translation.y)
                    cardImageView.transform = CGAffineTransform(rotationAngle: yFromCenter/verticalDivisor)
                    nextCardImageView.alpha = abs(cardImageView.center.y - pfImageOriginalCenter.y) / pfImageOriginalCenter.y
                }
            } else {
                direction = .horizontal
                cardImageView.center = CGPoint(x: pfImageOriginalCenter.x + translation.x, y: pfImageOriginalCenter.y)
                nextCardImageView.alpha = abs(cardImageView.center.x - pfImageOriginalCenter.x) / pfImageOriginalCenter.x
                if upOrLow == true {
                    cardImageView.transform = CGAffineTransform(rotationAngle: xFromCenter/horizontalDivisor)
                } else {
                    cardImageView.transform = CGAffineTransform(rotationAngle: -1*(xFromCenter/horizontalDivisor))

                }
            }

        } else if sender.state == .ended {
            if translation.x > 50 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.cardImageView.center.x = 1000
                    self.cardImageView.transform = CGAffineTransform(rotationAngle: xFromCenter/self.horizontalDivisor)
                    self.nextCardImageView.alpha = 1
                })
                swapCards()
//                keepBucket.append((image: cardImageView.image!, bucket: .keep))
            } else if translation.x < -50 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.cardImageView.center.x = -1000
                    self.cardImageView.transform = CGAffineTransform(rotationAngle: xFromCenter/self.horizontalDivisor)
                    self.nextCardImageView.alpha = 1

                })
//                removeBucket.append((image: cardImageView.image!, bucket: .remove))
                swapCards()
            }
            else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.cardImageView.transform = CGAffineTransform.identity
                    self.cardImageView.center = self.pfImageOriginalCenter
                    self.nextCardImageView.alpha = 1
                })
            }
            direction = nil
        }
    }


    private func swapCards() {
        let cardRef = cardImageView
        cardImageView = nextCardImageView
        nextCardImageView = cardRef
        cardsSuperView.sendSubviewToBack(nextCardImageView)
        nextCardImageView.isHidden = true
        index += 1
        if index == colors.count {
            present(BucketsTabBarController(), animated: true, completion: nil)
        } else {
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [unowned self] _ in
                self.nextCardImageView.transform = .identity
                self.nextCardImageView.center = self.pfImageOriginalCenter
                self.nextCardImageView.backgroundColor = self.colors[self.index]
                self.nextCardImageView.isHidden = false
            }
        }
    }

}
