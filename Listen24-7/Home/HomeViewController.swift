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
    var sectionTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewHome.dataSource = self
        tableViewHome.delegate = self
        parseJSON()
        registerCells()
    }
    
    func parseJSON(){
        viewModel.parseJSON("app") { success in
            if success {
                DispatchQueue.main.async {
                    self.tableViewHome.reloadData()
                }
            } else {
                print("parseJSON error")
            }
        }
    }
    
    func registerCells() {
        tableViewHome.register(SquareTableViewCell.self, forCellReuseIdentifier: SquareTableViewCell.identifier)
        tableViewHome.register(HeadlineTableViewCell.self, forCellReuseIdentifier: HeadlineTableViewCell.identifier)
        tableViewHome.register(CircleTableViewCell.self, forCellReuseIdentifier: CircleTableViewCell.identifier)
        tableViewHome.register(SuggestionTableViewCell.self, forCellReuseIdentifier: SuggestionTableViewCell.identifier)
        tableViewHome.register(LatestTableViewCell.self, forCellReuseIdentifier: LatestTableViewCell.identifier)
        tableViewHome.register(Top10TableViewCell.self, forCellReuseIdentifier: Top10TableViewCell.identifier)
    }
}

extension HomeViewController {
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
        case .cell_headline:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineTableViewCell.identifier, for: indexPath) as! HeadlineTableViewCell
            return cell
        case .cell_square:
            let cell = tableView.dequeueReusableCell(withIdentifier: SquareTableViewCell.identifier, for: indexPath) as! SquareTableViewCell
            return cell
        case .cell_circle:
            let cell = tableView.dequeueReusableCell(withIdentifier: CircleTableViewCell.identifier, for: indexPath) as! CircleTableViewCell
            return cell
        case .cell_suggestion:
            let cell = tableView.dequeueReusableCell(withIdentifier: SuggestionTableViewCell.identifier, for: indexPath) as! SuggestionTableViewCell
            return cell
        case .cell_latest:
            let cell = tableView.dequeueReusableCell(withIdentifier: LatestTableViewCell.identifier, for: indexPath) as! LatestTableViewCell
            return cell
        case .cell_top10:
            let cell = tableView.dequeueReusableCell(withIdentifier: Top10TableViewCell.identifier, for: indexPath) as! Top10TableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.responseData[section].title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 20))
        
        let lblTitleCell = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: 40))
        lblTitleCell.text = viewModel.responseData[section].title
        lblTitleCell.font = UIFont(name: "Futura-Bold", size: 17)
        viewHeader.addSubview(lblTitleCell)
        
        return viewHeader
    }
}

