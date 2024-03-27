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
}
