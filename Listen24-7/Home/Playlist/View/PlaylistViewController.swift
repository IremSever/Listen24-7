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
    var selectedPlaylistId: Int? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPlaylistTableView()
        loadData()
    }
    
    private func loadData() {
      viewModel.fetchPlaylistData(selectedPlaylistId: String(selectedPlaylistId ?? 0)) { [weak self] playlist in
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
        //print("**************************\( selectedPlaylist?.response?.count ?? 0)")
        return selectedPlaylist?.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewPlaylist.dequeueReusableCell(withIdentifier: PlaylistTableViewCell.identifier, for: indexPath) as! PlaylistTableViewCell
        if let playlist = selectedPlaylist {
            if let playlistResponse = playlist.response?[indexPath.row] {
                cell.configure(with: playlistResponse)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaylistId = selectedPlaylist?.response?[indexPath.row].id
        postSelectedPlaylistId()
    }
    
    func postSelectedPlaylistId() {
        guard let selectedPlaylistId = selectedPlaylistId else {
            return
        }
        
        let playlistWebService = PlaylistWebservice()
        playlistWebService.postPlaylistData(playlistId: String(selectedPlaylistId)) { result in
            switch result {
            case .success(let playlistModel):
                print("Playlist post is success: ") //\(playlistModel)
            case .failure(let error):
                print("Playlist post is failed: \(error)")
            }
        }
    }
}
