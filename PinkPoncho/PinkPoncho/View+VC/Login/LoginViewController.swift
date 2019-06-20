//
//  LoginViewController.swift
//  PinkPoncho
//
//  Created by Jacob Mittelstaedt on 6/19/19.
//  Copyright © 2019 Jacob Mittelstaedt. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func didEnterUrl(_ sender: UITextField) {
        guard let urlString = sender.text else {
            print("url field was empty")
            return
        }
        let url = URL(fileURLWithPath: "http://192.168.1.2:8080/ccapi")
        let request = URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(data, response, error)
        }.resume()
    }

    @IBAction func connect(_ sender: UIButton) {
        let url = URL(fileURLWithPath: "http://192.168.1.2:8080/ccapi")
        let request = URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(data, response, error)
            }.resume()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
