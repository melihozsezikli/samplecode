//
//  ViewController.swift
//  CodeChallenge
//
//  Created by Theuner, Heiko on 04.02.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    func showAlert(title: String = "Warning", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true)
    }
    
}

