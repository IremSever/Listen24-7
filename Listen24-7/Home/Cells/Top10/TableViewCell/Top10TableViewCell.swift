//
//  Top10TableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class Top10TableViewCell: UITableViewCell {
    static let identifier = "Top10TableView"
    private var collectionViewTop10: UICollectionView!
    var dataArray: [Response] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createTop10CollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createTop10CollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        collectionViewTop10 = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionViewTop10.translatesAutoresizingMaskIntoConstraints = false
        collectionViewTop10.delegate = self
        collectionViewTop10.dataSource = self
        collectionViewTop10.register(UINib(nibName: "Top10CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Top10CollectionViewCell.identifier)
        collectionViewTop10.backgroundColor = UIColor.clear

        addSubview(collectionViewTop10)

        NSLayoutConstraint.activate([
            collectionViewTop10.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionViewTop10.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewTop10.topAnchor.constraint(equalTo: topAnchor),
            collectionViewTop10.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension Top10TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Top10CollectionViewCell.identifier, for: indexPath) as! Top10CollectionViewCell
        let data = dataArray[indexPath.item]
    

        return cell
    }
}
