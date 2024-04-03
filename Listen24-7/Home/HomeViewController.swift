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
    var viewModelHeader = HeaderViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewHome.dataSource = self
        tableViewHome.delegate = self
        loadData()
        registerCells()
        tableViewHome.separatorStyle = .none
    }
    
    private func loadData() {
        viewModelHeader.fetchHeaderData {
            [weak self] in
            DispatchQueue.main.async {
                self?.registerCells()
                self?.tableViewHome.reloadData()
            }
        }
        viewModel.fetchHomeData {
            [weak self] in
            DispatchQueue.main.async {
                self?.registerCells()
                self?.tableViewHome.reloadData()
            }
        }
    }
    
    func registerCells() {
        tableViewHome.register(UINib(nibName: "HeadlineTableViewCell", bundle: nil), forCellReuseIdentifier: HeadlineTableViewCell.identifier)
        tableViewHome.register(UINib(nibName: "SquareTableViewCell", bundle: nil), forCellReuseIdentifier: SquareTableViewCell.identifier)
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
            return viewModel.home.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let dataHeader = viewModelHeader.header
            let cell = tableViewHome.dequeueReusableCell(withIdentifier: "HeadlineTableViewCell", for: indexPath) as! HeadlineTableViewCell
            cell.updateDataArray(with: [News(response: dataHeader, status: true)])
            return cell
        } else {
            let dataHome = viewModel.home[indexPath.row]
            switch dataHome.template {
            case "SLIDER", "STANDARD":
                let cell = tableView.dequeueReusableCell(withIdentifier: SquareTableViewCell.identifier, for: indexPath) as! SquareTableViewCell
                cell.updateDataArray(with: dataHome)
                addTitle(to: cell, title: viewModel.home[indexPath.row].name ?? "Default Title")
                return cell
            case "RADIO":
                let cell = tableView.dequeueReusableCell(withIdentifier: CircleTableViewCell.identifier, for: indexPath) as! CircleTableViewCell
                cell.updateDataArray(with: dataHome)
                addTitle(to: cell, title: viewModel.home[indexPath.row].name ?? "Default Title")
                return cell
            case "LASTSONGS":
                let cell = tableView.dequeueReusableCell(withIdentifier: LatestTableViewCell.identifier, for: indexPath) as! LatestTableViewCell
                cell.updateDataArray(with: dataHome)
                addTitle(to: cell, title: viewModel.home[indexPath.row].name ?? "Default Title")
                return cell
            case "TOPFRAMEPLAYLISTS":
                let cell = tableView.dequeueReusableCell(withIdentifier: SuggestionTableViewCell.identifier, for: indexPath) as! SuggestionTableViewCell
                cell.updateDataArray(with: dataHome)
                return cell
            case "TOPFRAMESONGS":
                let cell = tableView.dequeueReusableCell(withIdentifier: Top10TableViewCell.identifier, for: indexPath) as! Top10TableViewCell
                cell.updateDataArray(with: dataHome)
                addTitle(to: cell, title: viewModel.home[indexPath.row].name ?? "Default Title")
                return cell
            default:
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 500
        } else {
            let dataHome = viewModel.home[indexPath.row]
            switch dataHome.template {
            case "SLIDER":
                return 160
            case "STANDARD":
                return 90
            case "RADIO":
                return 140
            case "LASTSONGS":
                return 130
            case "TOPFRAMEPLAYLISTS":
                return 0
            case "TOPFRAMESONGS":
                return 140
            default:
                return 200
            }
        }
    }
    func addTitle(to contentView: UIView, title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // cell selected false
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
           return false
       }
}
