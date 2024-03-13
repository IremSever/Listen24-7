//
//  HeadlineTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell {
    static let identifier = "HeadlineTableView"
    private var collectionViewHeadline: UICollectionView!
    var dataArray: [Response] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createHeadlineCollectionView()
        setDataArray([])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createHeadlineCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionViewHeadline = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionViewHeadline.translatesAutoresizingMaskIntoConstraints = false
        collectionViewHeadline.delegate = self
        collectionViewHeadline.dataSource = self
        collectionViewHeadline.register(UINib(nibName: "HeadlineCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: HeadlineCollectionViewCell.identifier)
        collectionViewHeadline.backgroundColor = UIColor.clear
        
        addSubview(collectionViewHeadline)
        
        NSLayoutConstraint.activate([
         collectionViewHeadline.leadingAnchor.constraint(equalTo: leadingAnchor),
         collectionViewHeadline.trailingAnchor.constraint(equalTo: trailingAnchor),
         collectionViewHeadline.topAnchor.constraint(equalTo: topAnchor),
         collectionViewHeadline.bottomAnchor.constraint(equalTo: bottomAnchor)
         ])
    }
    func setDataArray(_ dataArray: [Response]) {
        self.dataArray = dataArray
        collectionViewHeadline.reloadData()
    }
}

extension HeadlineTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCollectionViewCell.identifier, for: indexPath) as! HeadlineCollectionViewCell
        let data = dataArray[indexPath.item]
        switch data.template {
        case .cell_headline:
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

