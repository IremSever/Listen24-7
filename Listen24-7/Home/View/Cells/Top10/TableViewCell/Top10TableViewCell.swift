//
//  Top10TableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

protocol top10CellProtocol {
    func didSelectedTop10(with song: Song)
}


class Top10TableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    static let identifier = "Top10TableViewCell"
    @IBOutlet weak var collectionViewTop10: UICollectionView!
    var dataArray: [Response] = []
    var selectedPlaylistId: Int?
    
    var delegate: top10CellProtocol?
    
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
        if let selectedSong = dataArray.first?.songs?[indexPath.row] {
            self.delegate?.didSelectedTop10(with: selectedSong)
        }
    }
}
