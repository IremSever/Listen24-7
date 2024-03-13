//
//  LatestTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class LatestTableViewCell: UITableViewCell {
    static let identifier = "LatestTableView"
    private var collectionViewLatest: UICollectionView!
    var dataArray: [Response] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createLatestCollectionView()
        setDataArray([])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLatestCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionViewLatest = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionViewLatest.translatesAutoresizingMaskIntoConstraints = false
        collectionViewLatest.delegate = self
        collectionViewLatest.dataSource = self
        collectionViewLatest.register(UINib(nibName: "LatestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: LatestCollectionViewCell.identifier)
        collectionViewLatest.backgroundColor = UIColor.clear
        
        addSubview(collectionViewLatest)
        
        NSLayoutConstraint.activate([
            collectionViewLatest.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionViewLatest.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewLatest.topAnchor.constraint(equalTo: topAnchor),
            collectionViewLatest.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    func setDataArray(_ dataArray: [Response]) {
        self.dataArray = dataArray
        collectionViewLatest.reloadData()
    }
}

extension LatestTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestCollectionViewCell.identifier, for: indexPath) as! LatestCollectionViewCell
        let data = dataArray[indexPath.item]
        switch data.template {
        case .cell_latest:
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
