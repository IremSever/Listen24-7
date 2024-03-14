//
//  Top10TableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class Top10TableViewCell: UITableViewCell {
    static let identifier = "Top10TableViewCell"
    private var collectionViewTop10: UICollectionView!
    var dataArray: [Response] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createTop10CollectionView()
        setDataArray([])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTop10CollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionViewTop10 = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionViewTop10.translatesAutoresizingMaskIntoConstraints = false
        collectionViewTop10.delegate = self
        collectionViewTop10.dataSource = self
        collectionViewTop10.register(UINib(nibName: "Top10CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Top10CollectionViewCell.identifier)
        collectionViewTop10.backgroundColor = UIColor.clear
        addSubview(collectionViewTop10)
        
    }
    func setDataArray(_ dataArray: [Response]) {
        self.dataArray = dataArray
        collectionViewTop10.reloadData()
    }
}

extension Top10TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Top10CollectionViewCell.identifier, for: indexPath) as! Top10CollectionViewCell
        let data = dataArray[indexPath.item]
        switch data.template {
        case .cell_top10:
            if let list = data.list {
                let info: Info? = list.indices.contains(indexPath.item) ? list[indexPath.item] : nil
                if let info = info {
                    cell.configure(with: info)
                }
            }
        default:
            break
        }
        return cell
    }
}
