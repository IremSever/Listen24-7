//
//  CircleTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class CircleTableViewCell: UITableViewCell {
    static let identifier = "CircleTableViewCell"
    private var collectionViewCircle: UICollectionView!
    var dataArray: [Response] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createCircleCollectionView()
        setDataArray([])
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
        
        collectionViewCircle = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionViewCircle.translatesAutoresizingMaskIntoConstraints = false
        collectionViewCircle.delegate = self
        collectionViewCircle.dataSource = self
        collectionViewCircle.register(UINib(nibName: "CircleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CircleCollectionViewCell.identifier)
        collectionViewCircle.backgroundColor = UIColor.clear
        
        addSubview(collectionViewCircle)
        
    }
    func setDataArray(_ dataArray: [Response]) {
        self.dataArray = dataArray
        collectionViewCircle.reloadData()
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

