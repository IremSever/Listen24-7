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
    var viewModel = HomeViewModel()
    var selectedPlaylist: [Info] = []
     
    override func awakeFromNib() {
        super.awakeFromNib()
        createPlaylistTableView()
    }
    
    func createPlaylistTableView() {
        tableViewPlaylist?.register(UINib(nibName: "PlaylistTableViewCell", bundle: nil), forCellReuseIdentifier: PlaylistTableViewCell.identifier)
        tableViewPlaylist?.backgroundColor = UIColor.clear
        tableViewPlaylist?.delegate = self
        tableViewPlaylist?.dataSource = self
        tableViewPlaylist?.showsHorizontalScrollIndicator = false
    }
    
    func updateDataArray(with selectedPlaylist: [Info]) {
        self.selectedPlaylist = selectedPlaylist
        tableViewPlaylist.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedPlaylist.first?.playlist?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewPlaylist.dequeueReusableCell(withIdentifier: PlaylistTableViewCell.identifier, for: indexPath) as! PlaylistTableViewCell
        if let item = selectedPlaylist.first?.playlist?[indexPath.row] {
            cell.configure(with: item)

            return cell
        }

        return cell
    }
}
