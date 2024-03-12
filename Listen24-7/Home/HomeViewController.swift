//
//  HomeViewController.swift
//  Listen24-7
//
//  Created by İrem Sever on 6.03.2024.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewHome: UITableView!
    var viewModel = HomeViewModel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableViewHome.dataSource = self
            tableViewHome.delegate = self
            registerCells()
            parseJSON()
        }
        
        func parseJSON() {
            viewModel.parseJSON("app") { [weak self] success in
                if success {
                    DispatchQueue.main.async {
                        self?.tableViewHome.reloadData()
                    }
                } else {
                    print("JSON parsing error.")
                }
            }
        }
        
        func registerCells() {
            tableViewHome.register(SquareTableViewCell.self, forCellReuseIdentifier: SquareTableViewCell.identifier)
            // Register other cell types here
        }
        
        // MARK: - UITableViewDataSource
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return viewModel.responseData.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.cellData(forSection: section).count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.cellData(forSection: indexPath.section)[indexPath.row]
        let templateType = data.template
        
        switch templateType {
        case .cell_square:
            let cell = tableView.dequeueReusableCell(withIdentifier: SquareTableViewCell.identifier, for: indexPath) as! SquareTableViewCell
            if let playlist = data.playlist {
                cell.setDataArray(playlist)
            }
            return cell
        case .cell_headline:
            let cell = tableView.dequeueReusableCell(withIdentifier: SquareTableViewCell.identifier, for: indexPath) as! SquareTableViewCell
            if let playlist = data.playlist {
                cell.setDataArray(playlist)
            }
            return cell
        case .cell_circle:
            let cell = tableView.dequeueReusableCell(withIdentifier: SquareTableViewCell.identifier, for: indexPath) as! SquareTableViewCell
            if let playlist = data.playlist {
                cell.setDataArray(playlist)
            }
            return cell
        case .cell_suggestion:
            let cell = tableView.dequeueReusableCell(withIdentifier: SquareTableViewCell.identifier, for: indexPath) as! SquareTableViewCell
            if let playlist = data.playlist {
                cell.setDataArray(playlist)
            }
            return cell
        case .cell_latest:
            let cell = tableView.dequeueReusableCell(withIdentifier: SquareTableViewCell.identifier, for: indexPath) as! SquareTableViewCell
            if let playlist = data.playlist {
                cell.setDataArray(playlist)
            }
            return cell
        case .cell_top10:
            let cell = tableView.dequeueReusableCell(withIdentifier: SquareTableViewCell.identifier, for: indexPath) as! SquareTableViewCell
            if let playlist = data.playlist {
                cell.setDataArray(playlist)
            }
            return cell
        }
    }
}
