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
    }
    
    private func loadData() {
        viewModel.fetchHeaderData { [weak self] in
            DispatchQueue.main.async {
                self?.viewModel.fetchHomeData { [weak self] in
                    DispatchQueue.main.async {
                        self?.registerCells()
                        self?.tableViewHome.reloadData()
                    }
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
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeaderInSection(section: section)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40))
        let lblTitleCell = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: 20))
        
        lblTitleCell.font = UIFont(name: "Futura-Bold", size: 13)
        viewHeader.addSubview(lblTitleCell)
        
        if section == 0 {
            lblTitleCell.text = viewModel.headerTitle()
        } else {
            lblTitleCell.text = viewModel.homeName()
        }
        
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 400
        } else {
            let dataHome = viewModel.home[indexPath.row]
            switch dataHome.template {
            case "SLIDER":
                return 300
            case "STANDART":
                return 120
            case "RADIO":
                return 100
            case "LASTSONGS":
                return 200
            case "TOPFRAMEPLAYLISTS":
                return 90
            case "TOPFRAMESONG":
                return 110
            default:
                return 200
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineTableViewCell.identifier, for: indexPath) as! HeadlineTableViewCell
            return cell
        } else {
            let dataHome = viewModel.home[indexPath.row]
            let cell: UITableViewCell
            switch dataHome.template {
            case "SLIDER":
                cell = tableView.dequeueReusableCell(withIdentifier: HeadlineTableViewCell.identifier, for: indexPath) as! HeadlineTableViewCell
            case "STANDART":
                cell = tableView.dequeueReusableCell(withIdentifier: SquareTableViewCell.identifier, for: indexPath) as! SquareTableViewCell
            case "RADIO":
                cell = tableView.dequeueReusableCell(withIdentifier: CircleTableViewCell.identifier, for: indexPath) as! CircleTableViewCell
            case "LASTSONGS":
                cell = tableView.dequeueReusableCell(withIdentifier: LatestTableViewCell.identifier, for: indexPath) as! LatestTableViewCell
            case "TOPFRAMEPLAYLISTS":
                cell = tableView.dequeueReusableCell(withIdentifier: SuggestionTableViewCell.identifier, for: indexPath) as! SuggestionTableViewCell
            case "TOPFRAMESONG":
                cell = tableView.dequeueReusableCell(withIdentifier: Top10TableViewCell.identifier, for: indexPath) as! Top10TableViewCell
            default:
                return UITableViewCell()
            }
            return cell
        }
    }
}
