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

    var divisor: CGFloat!
    var pfImageOriginalCenter: CGPoint!
    var index = 0
    let colors: [UIColor] = [.black, .red, .orange]
    override func viewDidLoad() {
        super.viewDidLoad()
        divisor = (view.frame.width / 2) / 0.61
        setSubviewProperties()
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

    @IBAction func didSwipeImage(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let translation = sender.translation(in: view)
        let upOrLow: Bool!

        if location.y <= 284{
            upOrLow = true
        } else {
            upOrLow = false
        }

        let xFromCenter = cardImageView.center.x - view.center.x

        if sender.state == .began {
            pfImageOriginalCenter = cardImageView.center
        } else if sender.state == .changed {
            cardImageView.center = CGPoint(x: pfImageOriginalCenter.x + translation.x, y: pfImageOriginalCenter.y)
            nextCardImageView.alpha = abs(cardImageView.center.x - view.center.x) / view.center.x
            if upOrLow == true{
                cardImageView.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
            }else{
                cardImageView.transform = CGAffineTransform(rotationAngle: -1*(xFromCenter/divisor))

            }

        } else if sender.state == .ended {
            if translation.x > 50 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.cardImageView.center.x = 1000
                    self.cardImageView.transform = CGAffineTransform(rotationAngle: xFromCenter/self.divisor)
                    self.nextCardImageView.alpha = 1
                })
            } else if translation.x < -50 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.cardImageView.center.x = -1000
                    self.cardImageView.transform = CGAffineTransform(rotationAngle: xFromCenter/self.divisor)
                    self.nextCardImageView.alpha = 1

                })
            }else {
                UIView.animate(withDuration: 0.1, animations: {
                    self.cardImageView.transform = CGAffineTransform.identity
                    self.cardImageView.center = self.pfImageOriginalCenter
                    self.nextCardImageView.alpha = 1
                })
            }
            let cardRef = cardImageView
            cardImageView = nextCardImageView
            nextCardImageView = cardRef
            cardsSuperView.sendSubviewToBack(nextCardImageView)
            nextCardImageView.isHidden = true
            index += 1
            if index == colors.count {
                present(BucketsTabBarController(), animated: true, completion: nil)
            }
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [unowned self] _ in
                self.nextCardImageView.transform = .identity
                self.nextCardImageView.center = self.pfImageOriginalCenter
                self.nextCardImageView.backgroundColor = self.colors[self.index]
                self.nextCardImageView.isHidden = false
            }
            index = (index + 1) % colors.count
//            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [unowned self] _ in
//                self.nextCardImageView.backgroundColor = self.colors[self.index]
//            }
        }
    }

    override func viewDidLayoutSubviews() {
    }

}
