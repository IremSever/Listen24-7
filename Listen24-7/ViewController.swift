//
//  ViewController.swift
//  Listen24-7
//
//  Created by İrem Sever on 5.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonStart(_ sender: UIButton) {
        performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
}

