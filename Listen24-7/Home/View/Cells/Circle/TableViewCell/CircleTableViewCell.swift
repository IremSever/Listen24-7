//
//  CircleTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class CircleTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionViewCircle: UICollectionView!
    static let identifier = "CircleTableViewCell"
    var dataArray: [Response] = []
    var selectedPlaylistId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createCircleCollectionView()
    }
    
    func createCircleCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionViewCircle.register(UINib(nibName: "CircleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CircleCollectionViewCell.identifier)
        layout.itemSize = CGSize(width: 50, height: 5)
        layout.minimumLineSpacing = 8
        collectionViewCircle.backgroundColor = UIColor.clear
        collectionViewCircle.delegate = self
        collectionViewCircle.dataSource = self
        collectionViewCircle.showsHorizontalScrollIndicator = false
    }
    
    func updateDataArray(with dataArray: Response) {
        self.dataArray = [dataArray]
        collectionViewCircle.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.first?.radioChannels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircleCollectionViewCell.identifier, for: indexPath) as! CircleCollectionViewCell
        if let item = dataArray.first?.radioChannels?[indexPath.row] {
            cell.configure(with: item)
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedPlaylistId = dataArray.first?.radioChannels?[indexPath.row].id else {
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
