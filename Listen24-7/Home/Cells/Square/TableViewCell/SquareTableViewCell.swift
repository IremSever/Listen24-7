//
//  SquareTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class SquareTableViewCell: UITableViewCell, UICollectionViewDataSource {
    static let identifier = "SquareTableViewCell"
    @IBOutlet weak var collectionViewSquare: UICollectionView!
    var dataArray: [Response] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createSquareCollectionView()
    }
    
    func createSquareCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionViewSquare.register(UINib(nibName: "SquareCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SquareCollectionViewCell.identifier)
        collectionViewSquare.backgroundColor = UIColor.clear
        collectionViewSquare.dataSource = self
        
        addSubview(collectionViewSquare)
    }
    
    func updateDataArray(with dataArray: [Response]) {
        self.dataArray = dataArray
        collectionViewSquare.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.first?.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquareCollectionViewCell.identifier, for: indexPath) as! SquareCollectionViewCell
        if let data = dataArray.first?.list?[indexPath.item] {
            cell.configure(with: data)
        }
        return cell
    }
}
