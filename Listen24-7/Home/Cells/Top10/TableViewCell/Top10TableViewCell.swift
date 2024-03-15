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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createTop10CollectionView()
    }
    
    func createTop10CollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionViewTop10.register(UINib(nibName: "Top10CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Top10CollectionViewCell.identifier)
        collectionViewTop10.backgroundColor = UIColor.clear
        collectionViewTop10.delegate = self
        collectionViewTop10.dataSource = self
    }
    
    func updateDataArray(with dataArray: [Response]) {
        self.dataArray = dataArray
        collectionViewTop10.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.first?.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Top10CollectionViewCell.identifier, for: indexPath) as! Top10CollectionViewCell
        if let item = dataArray.first?.list?[indexPath.row] {
            cell.configure(with: item)
            return cell
        }
        return cell
    }
}

