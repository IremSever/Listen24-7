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
    var selectedPlaylistSongs: [PlaylistSongs]?
    var selectedPlaylistId: Int?
    
    var listForPlayer: [PlaylistResponse] = []
    var selectedIndex: Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPlayTableView()
        tableViewPlay.separatorStyle = .none
        tableViewPlay.showsVerticalScrollIndicator = false
        buttonBack.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        print("items:: ", selectedIndex , listForPlayer)
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
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
            
            if let songs = selectedPlaylistSongs {
               // cell.configure(with: songs[indexPath.row])
            }
            return cell
        }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedSongId = selectedPlaylistSongs?[indexPath.row].id {
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
