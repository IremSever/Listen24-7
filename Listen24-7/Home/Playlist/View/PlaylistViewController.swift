//
//  PlaylistViewController.swift
//  Listen24-7
//
//  Created by IREM SEVER on 20.03.2024.
//

import Foundation
import UIKit

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var imgAppIcon: UIImageView!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonShare: UIButton!
    @IBOutlet weak var tableViewPlaylistTop: UITableView!
    @IBOutlet weak var tableViewPlaylist: UITableView!
    var viewModel = PlaylistViewModel()
    var selectedPlaylist: [PlaylistResponse] = []
    var selectedPlaylistId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewPlaylistTop.superview?.addSubview(tableViewPlaylistTop)
        createPlaylistTableView()
        loadData()
        tableViewPlaylist.separatorStyle = .none
        tableViewPlaylist.showsVerticalScrollIndicator = false
        buttonBack.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.bringSubviewToFront(buttonBack)
        view.bringSubviewToFront(buttonShare)
        view.bringSubviewToFront(imgAppIcon)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func loadData() {
        guard let selectedPlaylistId = selectedPlaylistId else { return }
        viewModel.fetchPlaylistData(selectedPlaylistId: String(selectedPlaylistId)) { [weak self] playlist in
            if let playlistResponses = playlist {
                self?.selectedPlaylist = playlistResponses
                self?.tableViewPlaylistTop.reloadData()
                self?.tableViewPlaylist.reloadData()
            }
        }
    }
    
    func createPlaylistTableView() {
        // Top
        tableViewPlaylistTop.register(UINib(nibName: "PlaylistTopTableViewCell", bundle: nil), forCellReuseIdentifier: PlaylistTopTableViewCell.identifier)
        tableViewPlaylistTop.backgroundColor = .clear
        tableViewPlaylistTop.isScrollEnabled = false
        tableViewPlaylistTop.delegate = self
        tableViewPlaylistTop.dataSource = self
        tableViewPlaylistTop.showsHorizontalScrollIndicator = false
        
        // Bottom
        tableViewPlaylist.register(UINib(nibName: "PlaylistTableViewCell", bundle: nil), forCellReuseIdentifier: PlaylistTableViewCell.identifier)
        tableViewPlaylist.backgroundColor = .clear
        tableViewPlaylist.delegate = self
        tableViewPlaylist.dataSource = self
        tableViewPlaylist.showsHorizontalScrollIndicator = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewPlaylistTop {
            return 1
        } else {
            return selectedPlaylist.first?.songs?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewPlaylistTop {
            let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistTopTableViewCell.identifier, for: indexPath) as! PlaylistTopTableViewCell
            if let firstItem = selectedPlaylist.first {
                cell.configureCover(data: firstItem)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistTableViewCell.identifier, for: indexPath) as! PlaylistTableViewCell
            
            
            if let item  = selectedPlaylist.first?.songs?[indexPath.row] {
                cell.configure(with: item)
                
                return cell
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewPlaylist {
            
            let indexRow =  indexPath.row
            
            let storyboard = UIStoryboard(name: "Play", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "PlayViewController") as? PlayViewController {
                vc.selectedIndex = indexRow
                vc.listForPlayer = selectedPlaylist
                self.navigationController?.pushViewController(vc, animated: true)
            }
            tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        }
    }
}
