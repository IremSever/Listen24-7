//
//  HeadlineTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate  {
    @IBOutlet weak var collectionViewHeadline: UICollectionView!
    static let identifier = "HeadlineTableViewCell"
    var dataArray: [News] = []
    var selectedIndex = 0
    var selectedPlaylistId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createHeadlineCollectionView()
    }
    
    func createHeadlineCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 350, height: 500)
        collectionViewHeadline.collectionViewLayout = layout
        collectionViewHeadline.register(UINib(nibName: "HeadlineCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: HeadlineCollectionViewCell.identifier)
        collectionViewHeadline.backgroundColor = .clear
        collectionViewHeadline.delegate = self
        collectionViewHeadline.dataSource = self
        collectionViewHeadline.showsHorizontalScrollIndicator = false
        collectionViewHeadline.isPagingEnabled = true
        
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = screenWidth - 100
        let horizontalInset = (screenWidth - cellWidth) / 2
        collectionViewHeadline.contentInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
    }
    
    func updateDataArray(with dataArray: [News]) {
        self.dataArray = dataArray
        collectionViewHeadline.reloadData()
        if dataArray.first?.response?.count ?? 0 > 0 {
            let selectedIndexIndexPath = IndexPath(row: selectedIndex + ((dataArray.first?.response?.count ?? 0) * 500), section: 0)
            collectionViewHeadline.scrollToItem(at: selectedIndexIndexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataArray.first?.response?.count ?? 0) * 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCollectionViewCell.identifier, for: indexPath) as! HeadlineCollectionViewCell
        let dataIndex = indexPath.row % (dataArray.first?.response?.count ?? 1)
        if let item = dataArray.first?.response?[dataIndex] {
            cell.configure(with: item)
            
            if let playlistId = item.id {
                self.selectedPlaylistId = Int(playlistId)
            } else {
                self.selectedPlaylistId = nil
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedPlaylistId = dataArray.first?.response?[indexPath.row].id else {
            return
        }
        self.selectedPlaylistId = Int(selectedPlaylistId)
        postSelectedPlaylistId()
        let viewController = UIStoryboard(name: "Playlist", bundle: nil).instantiateViewController(withIdentifier: "PlaylistViewController") as! PlaylistViewController
        viewController.selectedPlaylistId = Int(selectedPlaylistId)
        
        if let tabBarController = self.window?.rootViewController as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                if let navigationController = selectedViewController as? UINavigationController {
                    navigationController.pushViewController(viewController, animated: true)
                } else {
                    selectedViewController.present(viewController, animated: true, completion: nil)
                }
            }
        } else if let navigationController = self.window?.rootViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            print("Error: Did not find available view controller")
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = screenWidth - 100
        let itemCount = dataArray.first?.response?.count ?? 1
        let currentIndex = Int(collectionViewHeadline.contentOffset.x / itemWidth) % itemCount
        selectedIndex = currentIndex
    }
    
    func postSelectedPlaylistId() {
        guard let selectedPlaylistId = selectedPlaylistId else {
            return
        }
        
        let playlistWebService = PlaylistWebservice()
        playlistWebService.postPlaylistData(playlistId: String(selectedPlaylistId)) { result in
            switch result {
            case .success(let playlistModel):
                print("Playlist post is success: \(playlistModel)") //\(playlistModel)
            case .failure(let error):
                print("Playlist post is failed: \(error)")
            }
        }
    }
}
