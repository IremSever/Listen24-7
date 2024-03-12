//
//  SquareTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class SquareTableViewCell: UITableViewCell {
    static let identifier = "SquareTableViewCell"
    private var collectionViewSquare: UICollectionView!
    var dataArray: [Response] = []
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSquareCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSquareCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        
        collectionViewSquare = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewSquare.translatesAutoresizingMaskIntoConstraints = false
        collectionViewSquare.register(SquareCollectionViewCell.self, forCellWithReuseIdentifier: SquareCollectionViewCell.identifier)
        collectionViewSquare.dataSource = self
        collectionViewSquare.delegate = self
        collectionViewSquare.showsHorizontalScrollIndicator = false
        
        addSubview(collectionViewSquare)
        
        NSLayoutConstraint.activate([
            collectionViewSquare.topAnchor.constraint(equalTo: topAnchor),
            collectionViewSquare.leadingAnchor.constraint(equalTo: leadingAnchor),
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
        cell.imgSquare.image = UIImage(named: Info.image)
        
        return cell
    }
}
