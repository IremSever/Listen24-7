//
//  SquareTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class SquareTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    static let identifier = "SquareTableViewCell"
   
    @IBOutlet weak var collectionViewSquare: UICollectionView!
    var dataArray: [Response] = []
        var selectedPlaylistId: Int?
        
        override func awakeFromNib() {
            super.awakeFromNib()
            createSquareCollectionView()
        }
        
        func createSquareCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            collectionViewSquare.register(UINib(nibName: "SquareCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SquareCollectionViewCell.identifier)
            layout.itemSize = CGSize(width: 100, height: 100)
            layout.minimumLineSpacing = 8
            collectionViewSquare.backgroundColor = UIColor.clear
            collectionViewSquare.delegate = self
            collectionViewSquare.dataSource = self
            collectionViewSquare.showsHorizontalScrollIndicator = false
        }
        
        func updateDataArray(with dataArray: Response) {
            self.dataArray = [dataArray]
            collectionViewSquare.reloadData()
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return dataArray.first?.playlists?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquareCollectionViewCell.identifier, for: indexPath) as! SquareCollectionViewCell
            if let item = dataArray.first?.playlists?[indexPath.row] {
                cell.configure(with: item)
                return cell
            }
            return cell
        }
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            guard let selectedPlaylistId = dataArray.first?.playlists?[indexPath.row].id else {
                return
            }
            self.selectedPlaylistId = selectedPlaylistId
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
                    print("Playlist post is success: \(playlistModel)")
                case .failure(let error):
                    print("Playlist post is failed: \(error)")
                }
            }
        }
    }
