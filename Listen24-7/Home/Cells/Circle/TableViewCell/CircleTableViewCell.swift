//
//  CircleTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class CircleTableViewCell: UITableViewCell {
    static let identifier = "CircleTableView"
    private var collectionViewCircle: UICollectionView!
    var dataArray: [Response] = []

    override func awakeFromNib() {
            super.awakeFromNib()
            
        }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createCircleCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createCircleCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        collectionViewCircle = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionViewCircle.translatesAutoresizingMaskIntoConstraints = false
        collectionViewCircle.delegate = self
        collectionViewCircle.dataSource = self
        collectionViewCircle.register(UINib(nibName: "CircleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CircleCollectionViewCell.identifier)
        collectionViewCircle.backgroundColor = UIColor.clear

        /*addSubview(collectionViewCircle)

        NSLayoutConstraint.activate([
            collectionViewCircle.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionViewCircle.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewCircle.topAnchor.constraint(equalTo: topAnchor),
            collectionViewCircle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])*/
    }
}

extension CircleTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircleCollectionViewCell.identifier, for: indexPath) as! CircleCollectionViewCell
        let data = dataArray[indexPath.item]
        switch data.template {
        case .cell_circle:
            cell.configure(with: data.info)
            return cell
        default:
            break
        }
        return cell
    }
}

