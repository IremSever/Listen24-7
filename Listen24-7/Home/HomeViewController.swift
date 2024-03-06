//
//  HomeViewController.swift
//  Listen24-7
//
//  Created by İrem Sever on 6.03.2024.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func parseJSON(_ name: String){
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {return}
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let respone = try JSONDecoder().decode(AppModel.self, from: data)
        } catch {
            debugPrint(error)
        }
    }
    
}
