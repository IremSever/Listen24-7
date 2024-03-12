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
            if let playlist = data.playlist?.first {
                cell.configure(with: playlist)
            }
        case .cell_headline:
            // Configure headline cell
            break
        case .cell_circle:
            // Configure circle cell
            break
        case .cell_suggestion:
            // Configure suggestion cell
            break
        case .cell_latest:
            // Configure latest cell
            break
        case .cell_top10:
            // Configure top 10 cell
            break
        }
        
        return cell
    }
}

class SquareCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgSquare: UIImageView!
    static let identifier = "SquareCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with info: Info) {
        if let imageName = info.image, let image = UIImage(named: imageName) {
            imgSquare.image = image
        } else {
            print("image is empty")
        }
    }
}
  collectionViewSquare.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewSquare.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        collectionViewSquare.backgroundColor = UIColor.white // Customize background color as needed
    }
}

extension SquareTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count // Assuming dataArray holds the data you want to display
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquareCollectionViewCell.identifier, for: indexPath) as? SquareCollectionViewCell else {
            fatalError("Failed to dequeue SquareCollectionViewCell")
        }
        
        let data = dataArray[indexPath.item]
        let imageURLString = data.image
        
        return cell
    }
}
