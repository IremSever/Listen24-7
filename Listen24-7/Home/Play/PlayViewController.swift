//
//  PlayViewController.swift
//  Listen24-7
//
//  Created by İrem Sever on 24.04.2024.
//

import Foundation
import UIKit
class PlayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableViewTop: UITableView!
    @IBOutlet weak var tableViewMid: UITableView!
    @IBOutlet weak var tableViewBottom: UITableView!
    
    static let identifier = "PlayViewController"
    
    var viewModel = PlaylistViewModel()
    var selectedPlaylist: PlaylistDetail?
    var selectedPlaylistId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        tableViewTop.separatorStyle = .none
    }
    
    private func loadData() {
        guard let selectedPlaylistId = selectedPlaylistId else { return }
        viewModel.fetchPlaylistData(selectedPlaylistId: String(selectedPlaylistId)) { [weak self] playlist in
            if let playlistResponses = playlist {
                self?.selectedPlaylist = PlaylistDetail(pageInfo: nil, response: playlistResponses, status: nil)
                self?.tableViewTop.reloadData()
                self?.tableViewTop.reloadData()
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedPlaylist?.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewMid {
            let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistTableViewCell.identifier, for: indexPath) as! PlaylistTableViewCell
            
            if let song = selectedPlaylist?.response?[indexPath.row].songs?.first {
                cell.configure(with: song)
            }
            return cell
        } else if tableView == tableViewTop {
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
