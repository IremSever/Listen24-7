//
//  SquareTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class SquareTableViewCell: UITableViewCell {
    static let identifier = "SquareTableView"
    private var collectionViewSquare: UICollectionView!
    var dataArray: [Response] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSquareCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSquareCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionViewSquare = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionViewSquare.translatesAutoresizingMaskIntoConstraints = false
        collectionViewSquare.delegate = self
        collectionViewSquare.dataSource = self
        collectionViewSquare.register(UINib(nibName: "SquareCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SquareCollectionViewCell.identifier)
        collectionViewSquare.backgroundColor = UIColor.clear
        
        addSubview(collectionViewSquare)
        
        NSLayoutConstraint.activate([
            collectionViewSquare.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionViewSquare.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewSquare.topAnchor.constraint(equalTo: topAnchor),
            collectionViewSquare.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    func setDataArray(_ dataArray: [Response]) {
        self.dataArray = dataArray
        collectionViewSquare.reloadData()
    }
}

extension SquareTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquareCollectionViewCell.identifier, for: indexPath) as! SquareCollectionViewCell
        let data = dataArray[indexPath.item]
        switch data.template {
        case .cell_square:
            if let list = data.list {
                let info: Info? = list.indices.contains(indexPath.item) ? list[indexPath.item] : nil
                if let info = info {
                    cell.configure(with: info)
                }
            }
            return cell
        default:
            break
        }
        return cell
    }
}

