//
//  PlaylistViewController.swift
//  Listen24-7
//
//  Created by IREM SEVER on 20.03.2024.
//

import Foundation
import UIKit

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewPlaylist: UITableView!
    var viewModel = PlaylistViewModel()
    var selectedPlaylist: PlaylistDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPlaylistTableView()
        loadData()
    }
    
    private func loadData() {
        viewModel.fetchPlaylistData { [weak self] playlist in
            if let playlistResponses = playlist {
                self?.selectedPlaylist = PlaylistDetail(pageInfo: nil, response: playlistResponses, status: nil)
            }
            self?.tableViewPlaylist.reloadData()
        }
    }
    
    func createPlaylistTableView() {
        tableViewPlaylist.register(UINib(nibName: "PlaylistTableViewCell", bundle: nil), forCellReuseIdentifier: PlaylistTableViewCell.identifier)
        tableViewPlaylist.backgroundColor = .clear
        tableViewPlaylist.delegate = self
        tableViewPlaylist.dataSource = self
        tableViewPlaylist.showsHorizontalScrollIndicator = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedPlaylist?.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewPlaylist.dequeueReusableCell(withIdentifier: PlaylistTableViewCell.identifier, for: indexPath) as! PlaylistTableViewCell
        if let playlist = selectedPlaylist {
            if let playlistResponse = playlist.response?[indexPath.row] {
                cell.configure(with: [playlistResponse])
            }
        }
        return cell
    }
}
