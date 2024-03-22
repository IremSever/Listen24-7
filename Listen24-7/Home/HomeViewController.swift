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
    var viewModelHome = HomeViewModel()
    var viewModelHeader = HeaderViewModel()
    var sectionTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewHome.dataSource = self
        tableViewHome.delegate = self
        loadData()
        registerCells()
        
    }
    
    private func loadData() {
        viewModelHeader.fetchHeaderData { [weak self] in
            DispatchQueue.main.async {
                self?.tableViewHome.reloadData()
            }
        }
        viewModelHome.fetchHomeData { [weak self] in
            DispatchQueue.main.async {
                self?.tableViewHome.reloadData()
            }
        }
    }
    
    func registerCells() {
        tableViewHome.register(UINib(nibName: "SquareTableViewCell", bundle: nil), forCellReuseIdentifier: SquareTableViewCell.identifier)
        tableViewHome.register(UINib(nibName: "HeadlineTableViewCell", bundle: nil), forCellReuseIdentifier: HeadlineTableViewCell.identifier)
        tableViewHome.register(UINib(nibName: "CircleTableViewCell", bundle: nil), forCellReuseIdentifier: CircleTableViewCell.identifier)
        tableViewHome.register(UINib(nibName: "SuggestionTableViewCell", bundle: nil), forCellReuseIdentifier: SuggestionTableViewCell.identifier)
        tableViewHome.register(UINib(nibName: "LatestTableViewCell", bundle: nil), forCellReuseIdentifier: LatestTableViewCell.identifier)
        tableViewHome.register(UINib(nibName: "Top10TableViewCell", bundle: nil), forCellReuseIdentifier: Top10TableViewCell.identifier)
    }
}

extension HomeViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModelHome.responseData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModelHome.responseData[section].title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40))
        
        let lblTitleCell = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: 20))
        lblTitleCell.text = viewModelHome.responseData[section].title
        lblTitleCell.font = UIFont(name: "Futura-Bold", size: 13)
        viewHeader.addSubview(lblTitleCell)
        
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = viewModelHome.cellData(forSection: indexPath.section)
        let templateType = data.first?.template
        switch templateType {
        case .cell_headline:
            return 400
        case .cell_square:
            return 120
        case .cell_circle:
            return 100
        case .cell_suggestion:
            return 200
        case .cell_latest:
            return 90
        case .cell_top10:
            return 110
        default:
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.cellData(forSection: indexPath.section)
        let templateType = data.first?.template
        //print("*******************data: \(data)")
        //print("*******************template: \(String(describing: templateType))")
        switch templateType {
        case .cell_headline:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineTableViewCell.identifier, for: indexPath) as! HeadlineTableViewCell
            cell.updateDataArray(with: data)
            return cell
        case .cell_square:
            let cell = tableView.dequeueReusableCell(withIdentifier: SquareTableViewCell.identifier, for: indexPath) as! SquareTableViewCell
            cell.updateDataArray(with: data)
            return cell
        case .cell_circle:
            let cell = tableView.dequeueReusableCell(withIdentifier: CircleTableViewCell.identifier, for: indexPath) as! CircleTableViewCell
            cell.updateDataArray(with: data)
            return cell
        case .cell_suggestion:
            let cell = tableView.dequeueReusableCell(withIdentifier: SuggestionTableViewCell.identifier, for: indexPath) as! SuggestionTableViewCell
            cell.updateDataArray(with: data)
            return cell
        case .cell_latest:
            let cell = tableView.dequeueReusableCell(withIdentifier: LatestTableViewCell.identifier, for: indexPath) as! LatestTableViewCell
            cell.updateDataArray(with: data)
            return cell
        case .cell_top10:
            let cell = tableView.dequeueReusableCell(withIdentifier: Top10TableViewCell.identifier, for: indexPath) as! Top10TableViewCell
            cell.updateDataArray(with: data)
            return cell
        default:
            return UITableViewCell()
            
        }
    }
}
