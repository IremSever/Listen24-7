//
//  Top10TableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class Top10TableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    static let identifier = "Top10TableViewCell"
    @IBOutlet weak var collectionViewTop10: UICollectionView!
    var dataArray: [Response] = []
    var selectedPlaylistId: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        createTop10CollectionView()
    }
    
    func createTop10CollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionViewTop10.register(UINib(nibName: "Top10CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Top10CollectionViewCell.identifier)
        layout.itemSize = CGSize(width: 250, height: 90)
        layout.minimumLineSpacing = 8
        collectionViewTop10.backgroundColor = .clear
        collectionViewTop10.delegate = self
        collectionViewTop10.dataSource = self
        collectionViewTop10.showsHorizontalScrollIndicator = false
    }
    
    func updateDataArray(with dataArray: Response) {
        self.dataArray = [dataArray]
        collectionViewTop10.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.first?.songs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Top10CollectionViewCell.identifier, for: indexPath) as! Top10CollectionViewCell
        if let item = dataArray.first?.songs?[indexPath.row] {
            cell.configure(with: item, index: indexPath.row)
            return cell
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedPlaylistId = dataArray.first?.songs?[indexPath.row].id else {
            return
        }
        self.selectedPlaylistId = selectedPlaylistId
        postSelectedPlaylistId()
        let viewController = UIStoryboard(name: "Play", bundle: nil).instantiateViewController(withIdentifier: "PlayViewController") as! PlayViewController
        
        viewController.selectedPlaylistId = selectedPlaylistId
        viewController.modalPresentationStyle = .fullScreen
        
        if let tabBarController = self.window?.rootViewController as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                selectedViewController.present(viewController, animated: true, completion: nil)
            }
        } else if let navigationController = self.window?.rootViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            print("Error: Did not find available view controller")
        }
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


