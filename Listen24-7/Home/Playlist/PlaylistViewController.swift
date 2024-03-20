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
    var dataArray: [Info] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createPlaylistTableView()
    }
    
    func createPlaylistTableView() {
        let layout = UITableViewCell()
       tableViewPlaylist.register(UINib(nibName: "PlaylistTableViewCell", bundle: nil), forCellWithReuseIdentifier: PlaylistTableViewCell.identifier)
        layout.itemSize = CGSize(width: 250, height: 350)
        layout.minimumLineSpacing = 8
        tableViewPlaylist.backgroundColor = UIColor.clear
        tableViewPlaylist.delegate = self
        tableViewPlaylist.dataSource = self
        tableViewPlaylist.showsHorizontalScrollIndicator = false
    }
    
    func updateDataArray(with dataArray: [Info]) {
        self.dataArray = dataArray
        tableViewPlaylist.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistTableViewCell.identifier, for: indexPath) as! PlaylistTableViewCell
        let data = viewModel.cellData(forSection: indexPath.section)
        cell.updateDataArray(with: data)
        return cell
        if let item = dataArray.playlist[indexPath.row] {
            cell.configure(with: item)
            return cell
        }
        return cell
    }
}
