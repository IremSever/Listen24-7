//
//  PlayViewController.swift
//  Listen24-7
//
//  Created by İrem Sever on 24.04.2024.
//

import Foundation
import UIKit
class PlayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableViewPlay: UITableView!
    @IBOutlet weak var buttonBack: UIButton!
    static let identifier = "PlayViewController"
    
    var viewModel = PlaylistViewModel()
    var selectedPlaylist: [PlaylistResponse]?
    var selectedPlaylistId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPlayTableView()
        loadData()
        tableViewPlay.separatorStyle = .none
        tableViewPlay.showsVerticalScrollIndicator = false
        buttonBack.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    
    private func loadData() {
        guard let selectedPlaylistId = selectedPlaylistId else { return }
        viewModel.fetchPlaylistData(selectedPlaylistId: String(selectedPlaylistId)) { [weak self] playlist in
            if let playlistResponses = playlist {
                self?.selectedPlaylist = playlistResponses
                self?.tableViewPlay.reloadData()
            }
        }
    }
    
    func createPlayTableView() {
        tableViewPlay.register(UINib(nibName: "PlayTableViewCell", bundle: nil), forCellReuseIdentifier: PlayTableViewCell.identifier)
        tableViewPlay.backgroundColor = .clear
        tableViewPlay.isScrollEnabled = false
        tableViewPlay.delegate = self
        tableViewPlay.dataSource = self
        tableViewPlay.showsHorizontalScrollIndicator = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewPlay.dequeueReusableCell(withIdentifier: PlayTableViewCell.identifier, for: indexPath) as! PlayTableViewCell
        
        /*if let item = selectedPlaylist?[indexPath.row] {
            cell.configure(with: item)
        }*/
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedSongId = selectedPlaylist?[indexPath.row].songs?.first?.id {
            postSelectedPlaylistId(selectedSongId)
        }
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
