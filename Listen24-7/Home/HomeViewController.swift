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
        loadData()
        registerCells()
    }
    
    private func loadData() {
        if numberOfSections(in: tableViewHome) == 0 {
            viewModel.fetchHeaderData { [weak self] in
                DispatchQueue.main.async {
                    self?.tableViewHome.reloadData()
                }
            }
        } else {
            viewModel.fetchHomeData { [weak self] in
                DispatchQueue.main.async {
                    self?.tableViewHome.reloadData()
                }
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.numberOfRowsInSection(section: section - 1)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return viewModel.header.first?.title
        } else {
            return viewModel.home.first?.name
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40))
        
        let lblTitleCell = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: 20))
        
        if section == 0 {
            lblTitleCell.text = viewModel.header[section].title
        } else {
            lblTitleCell.text = viewModel.home[section].name
        }
        
        lblTitleCell.font = UIFont(name: "Futura-Bold", size: 13)
        viewHeader.addSubview(lblTitleCell)
        
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let dataHeader = viewModel.header[indexPath.row]
            return 400
        } else {
            let dataHome = viewModel.home[indexPath.row]
            switch dataHome.template {
            case .slider:
                return 300
            case .standart:
                return 120
            case .radio:
                return 100
            case .lastSongs:
                return 200
            case .topFramePlaylist:
                return 90
            case .topFrameSong:
                return 110
            default: 
                return 200
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let dataHeader = viewModel.header[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineTableViewCell.identifier, for: indexPath) as! HeadlineTableViewCell
            return cell
        } else {
            let dataHome = viewModel.home[indexPath.row]
            let cell: UITableViewCell
            switch dataHome.template {
            case .slider:
                cell = tableView.dequeueReusableCell(withIdentifier: HeadlineTableViewCell.identifier, for: indexPath) as! HeadlineTableViewCell
            case .standart:
                cell = tableView.dequeueReusableCell(withIdentifier: SquareTableViewCell.identifier, for: indexPath) as! SquareTableViewCell
            case .radio:
                cell = tableView.dequeueReusableCell(withIdentifier: CircleTableViewCell.identifier, for: indexPath) as! CircleTableViewCell
            case .lastSongs:
                cell = tableView.dequeueReusableCell(withIdentifier: SuggestionTableViewCell.identifier, for: indexPath) as! SuggestionTableViewCell
            case .topFramePlaylist:
                cell = tableView.dequeueReusableCell(withIdentifier: LatestTableViewCell.identifier, for: indexPath) as! LatestTableViewCell
            case .topFrameSong:
                cell = tableView.dequeueReusableCell(withIdentifier: Top10TableViewCell.identifier, for: indexPath) as! Top10TableViewCell
            default:
                return UITableViewCell()
            }
            return cell
        }
    }
}
