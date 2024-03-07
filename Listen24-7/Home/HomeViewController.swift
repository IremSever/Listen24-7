//
//  HomeViewController.swift
//  Listen24-7
//
//  Created by İrem Sever on 6.03.2024.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableViewHome: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON("app")
    }
    
    func parseJSON(_ name: String){
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
            print("Not found json file")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(AppModel.self, from: data)
            
            handleResponse(response)
        } catch {
            print("JSON conversion error: \(error)")
        }
    }
    
    func handleResponse(_ response: AppModel) {
        print("JSON data has been processed successfully")
    }
}
