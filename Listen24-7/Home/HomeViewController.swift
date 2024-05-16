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
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.backgroundColor = .none
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

extension HomeViewController: squareCellProtocol, headlineCellProtocol, circleCellProtocol, suggestionCellProtocol, latestCellProtocol, top10CellProtocol {
    
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
            cell.delegate = self
            cell.updateDataArray(with: [News(response: dataHeader, status: true)])
            return cell
        } else {
            let dataHome = viewModel.home[indexPath.row]
            switch dataHome.template {
            case "SLIDER", "STANDARD":
                let cell = tableView.dequeueReusableCell(withIdentifier: SquareTableViewCell.identifier, for: indexPath) as! SquareTableViewCell
                if let playlists = dataHome.playlists, !playlists.isEmpty {
                    cell.updateDataArray(with: dataHome)
                    cell.delegate = self
                    addTitle(to: cell, title: viewModel.home[indexPath.row].name ?? "Default Title")
                    return cell
                } else {
                    return UITableViewCell()
                }
            case "RADIO":
                let cell = tableView.dequeueReusableCell(withIdentifier: CircleTableViewCell.identifier, for: indexPath) as! CircleTableViewCell
                if let radioChannels = dataHome.radioChannels, !radioChannels.isEmpty {
                    cell.updateDataArray(with: dataHome)
                    cell.delegate = self
                    addTitle(to: cell, title: viewModel.home[indexPath.row].name ?? "Default Title")
                    return cell
                } else {
                    return UITableViewCell()
                }
            case "LASTSONGS":
                let cell = tableView.dequeueReusableCell(withIdentifier: LatestTableViewCell.identifier, for: indexPath) as! LatestTableViewCell
                if let songs = dataHome.songs, !songs.isEmpty {
                    cell.updateDataArray(with: dataHome)
                    addTitle(to: cell, title: viewModel.home[indexPath.row].name ?? "Default Title")
                    cell.delegate = self
                    return cell
                } else {
                    return UITableViewCell()
                }
            case "TOPFRAMEPLAYLISTS":
                let cell = tableView.dequeueReusableCell(withIdentifier: SuggestionTableViewCell.identifier, for: indexPath) as! SuggestionTableViewCell
                if let songs = dataHome.songs, !songs.isEmpty {
                    cell.updateDataArray(with: dataHome)
                    addTitle(to: cell, title: viewModel.home[indexPath.row].name ?? "Default Title")
                    cell.delegate = self
                    return cell
                } else {
                    return UITableViewCell()
                }
            case "TOPFRAMESONGS":
                let cell = tableView.dequeueReusableCell(withIdentifier: Top10TableViewCell.identifier, for: indexPath) as! Top10TableViewCell
                if let songs = dataHome.songs, !songs.isEmpty {
                    cell.updateDataArray(with: dataHome)
                    addTitle(to: cell, title: viewModel.home[indexPath.row].name ?? "Default Title")
                    cell.delegate = self
                    return cell
                } else {
                    return UITableViewCell()
                }
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
            case "SLIDER", "STANDARD":
                if let playlists = dataHome.playlists, !playlists.isEmpty {
                    return 160
                } else {
                    return 0
                }
            case "RADIO":
                if let radioChannels = dataHome.radioChannels, !radioChannels.isEmpty  {
                    return 140
                } else {
                    return 0
                }
            case "LASTSONGS":
                if let songs = dataHome.songs, !songs.isEmpty {
                    return 130
                } else {
                    return 0
                }
            case "TOPFRAMEPLAYLISTS":
                if let songs = dataHome.songs, !songs.isEmpty {
                    return 400
                } else {
                    return 0
                }
            case "TOPFRAMESONGS":
                if let songs = dataHome.songs, !songs.isEmpty {
                    return 150
                } else {
                    return 0
                }
            default:
                return 200
            }
        }
    }
    
    func addTitle(to contentView: UIView, title: String) {
        var titleLabel = contentView.viewWithTag(1000) as? UILabel
        if titleLabel == nil {
            titleLabel = UILabel()
            titleLabel?.tag = 1000
            titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            titleLabel?.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(titleLabel!)
            
            NSLayoutConstraint.activate([
                titleLabel!.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
                titleLabel!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                titleLabel!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                titleLabel!.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
        titleLabel?.text = title
    }
    
    // cell selected false
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    func didSelectedSquare(with id: Int) {
        let storyboard = UIStoryboard(name: "Playlist", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "PlaylistViewController") as? PlaylistViewController {
            vc.selectedPlaylistId = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func didSelectedHeadline(with id: Int) {
        let storyboard = UIStoryboard(name: "Playlist", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "PlaylistViewController") as? PlaylistViewController {
            vc.selectedPlaylistId = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func didSelectedCircle(with radioChannel: RadioChannel) {
        let storyboard = UIStoryboard(name: "Play", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "PlayViewController") as? PlayViewController {
            vc.selectedRadioChannel = radioChannel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func didSelectedSuggestion(with id: Int) {
        let storyboard = UIStoryboard(name: "Play", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "PlayViewController") as? PlayViewController {
            vc.selectedPlaylistId = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func didSelectedLatest(with song: [Song], songIndex: Int) {
        let storyboard = UIStoryboard(name: "Play", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "PlayViewController") as? PlayViewController {
            vc.selectedSong = song
            vc.songIndex = songIndex
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    func didSelectedTop10(with song: [Song], songIndex: Int) {
        print("Selected song index: \(songIndex)")
        let storyboard = UIStoryboard(name: "Play", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "PlayViewController") as? PlayViewController {
            vc.selectedSong = song
            vc.songIndex = songIndex
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
