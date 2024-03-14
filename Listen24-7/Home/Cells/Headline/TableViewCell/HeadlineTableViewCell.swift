//
//  HeadlineTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate  {
    static let identifier = "HeadlineTableViewCell"
    private var collectionViewHeadline: UICollectionView!
    var dataArray: [Response] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createHeadlineCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createHeadlineCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.width * 0.7)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 15

        collectionViewHeadline = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionViewHeadline.register(HeadlineCollectionViewCell.self, forCellWithReuseIdentifier: HeadlineCollectionViewCell.identifier)
        collectionViewHeadline.delegate = self
        collectionViewHeadline.dataSource = self
        collectionViewHeadline.showsHorizontalScrollIndicator = false
        collectionViewHeadline.backgroundColor = UIColor.clear
        
        addSubview(collectionViewHeadline)
    }
    func updateDataArray(with dataArray: [Response]) {
        self.dataArray = dataArray
        collectionViewHeadline.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCollectionViewCell.identifier, for: indexPath) as! HeadlineCollectionViewCell
        let data = dataArray[indexPath.item]
        switch data.template {
        case .cell_square:
            if let list = data.list {
                let info: Info? = list.indices.contains(indexPath.item) ? list[indexPath.item] : nil
                if let info = info {
                    cell.configure(with: info)
                }
            }
        default:
            print("problem")
        }
        return cell
    }
}

