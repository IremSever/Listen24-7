//
//  CircleTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class CircleTableViewCell: UITableViewCell, UICollectionViewDataSource {
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
        collectionViewCircle.backgroundColor = UIColor.clear
        collectionViewCircle.dataSource = self
        
        addSubview(collectionViewCircle)
    }
    
    func updateDataArray(with dataArray: [Response]) {
        self.dataArray = dataArray
        collectionViewCircle.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.first?.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircleCollectionViewCell.identifier, for: indexPath) as! CircleCollectionViewCell
        if let data = dataArray.first?.list?[indexPath.item] {
            cell.configure(with: data)
        }
        return cell
    }
}
