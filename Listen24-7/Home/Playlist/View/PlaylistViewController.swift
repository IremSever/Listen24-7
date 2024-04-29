//
//  PlaylistViewController.swift
//  Listen24-7
//
//  Created by IREM SEVER on 20.03.2024.
//

import Foundation
import UIKit

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableViewPlaylistTop: UITableView!
    @IBOutlet weak var tableViewPlaylist: UITableView!
    var viewModel = PlaylistViewModel()
    var selectedPlaylist: PlaylistDetail?
    var selectedPlaylistId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewPlaylistTop.superview?.addSubview(tableViewPlaylistTop)
        tableViewPlaylist.superview?.addSubview(tableViewPlaylist)
        createPlaylistTableView()
        loadData()
        tableViewPlaylist.separatorStyle = .none
    }
    
    private func loadData() {
        guard let selectedPlaylistId = selectedPlaylistId else { return }
        viewModel.fetchPlaylistData(selectedPlaylistId: String(selectedPlaylistId)) { [weak self] playlist in
            if let playlistResponses = playlist {
                self?.selectedPlaylist = PlaylistDetail(pageInfo: nil, response: playlistResponses, status: nil)
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
        return selectedPlaylist?.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewPlaylist {
            let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistTableViewCell.identifier, for: indexPath) as! PlaylistTableViewCell
            
            guard let song = selectedPlaylist?.response?[indexPath.row].songs?[indexPath.row] else { return cell }
            
            cell.configure(with: song)
            return cell
        } else if tableView == tableViewPlaylistTop {
            let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistTopTableViewCell.identifier, for: indexPath) as! PlaylistTopTableViewCell
            cell.configureCover(data: selectedPlaylist?.response?[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedSongId = selectedPlaylist?.response?[indexPath.row].id else { return }
        postSelectedPlaylistId(selectedSongId)
    }
    
    func postSelectedPlaylistId(_ selectedSongId: Int) {
        let playlistWebService = PlaylistWebservice()
        playlistWebService.postPlaylistData(playlistId: String(selectedSongId)) { result in
            switch result {
            case .success(let playlistModel):
                print("Playlist post is success: \(playlistModel)")
            case .failure(let error):
                print("Playlist post is failed: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
