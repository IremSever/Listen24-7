//
//  LatestTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

protocol latestCellProtocol {
    func didSelectedLatest(with song: Song)
}

class LatestTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    static let identifier = "LatestTableViewCell"
    @IBOutlet weak var collectionViewLatest: UICollectionView!
    var dataArray: [Response] = []
    var selectedPlaylistId: Int?
    var delegate: latestCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createLatestCollectionView()
    }
    
    func createLatestCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionViewLatest.register(UINib(nibName: "LatestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: LatestCollectionViewCell.identifier)
        layout.itemSize = CGSize(width: 250, height: 350)
        layout.minimumLineSpacing = 8
        collectionViewLatest.backgroundColor = UIColor.clear
        collectionViewLatest.delegate = self
        collectionViewLatest.dataSource = self
        collectionViewLatest.showsHorizontalScrollIndicator = false
    }
    
    func updateDataArray(with dataArray: Response) {
        self.dataArray = [dataArray]
        collectionViewLatest.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.first?.songs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestCollectionViewCell.identifier, for: indexPath) as! LatestCollectionViewCell
        
        if let item = dataArray.first?.songs?[indexPath.row] {
            cell.configure(with: item)
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedSong = dataArray.first?.songs?[indexPath.row] {
            self.delegate?.didSelectedLatest(with: selectedSong)
        }
    }
}
