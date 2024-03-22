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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createHeadlineCollectionView()
        /*let tapGesture = UITapGestureRecognizer(target: self, action: #selector(collectionViewTapped))
        collectionViewHeadline.addGestureRecognizer(tapGesture)
        collectionViewHeadline.isUserInteractionEnabled = true*/
    }
    
    func createHeadlineCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionViewHeadline.register(UINib(nibName: "HeadlineCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: HeadlineCollectionViewCell.identifier)
        collectionViewHeadline.backgroundColor = UIColor.clear
        collectionViewHeadline.delegate = self
        collectionViewHeadline.dataSource = self
        collectionViewHeadline.showsHorizontalScrollIndicator = false
    }
    
    func updateDataArray(with dataArray: [News]) {
        self.dataArray = dataArray
        collectionViewHeadline.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.first?.response.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCollectionViewCell.identifier, for: indexPath) as! HeadlineCollectionViewCell
        if let item = dataArray.first?.response[indexPath.row] {
            cell.configure(with: item)
            return cell
        }
        return cell
    }
    
    /*@objc func collectionViewTapped(_ gesture: UITapGestureRecognizer) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Playlist", bundle: nil)
        if let playlistVC = storyboard.instantiateViewController(withIdentifier: "PlaylistViewController") as? PlaylistViewController {
            if let currentVC = sceneDelegate.window?.rootViewController {
                currentVC.present(playlistVC, animated: true, completion: nil)
            }
        

            //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            //        let size = CGSize(width: 200, height: 200)
            //        return size
            //      }
            //      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            //        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 20)
            //      }
        }
    }*/
}
    
