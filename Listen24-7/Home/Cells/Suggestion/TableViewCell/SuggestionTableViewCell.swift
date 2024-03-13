//
//  SuggestionTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class SuggestionTableViewCell: UITableViewCell {
    static let identifier = "SusggestionTableView"
    private var collectionViewSuggestion: UICollectionView!
    var dataArray: [Response] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSuggestionCollectionView()
        setDataArray([])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSuggestionCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionViewSuggestion = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionViewSuggestion.translatesAutoresizingMaskIntoConstraints = false
        collectionViewSuggestion.delegate = self
        collectionViewSuggestion.dataSource = self
        collectionViewSuggestion.register(UINib(nibName: "SuggestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SuggestionCollectionViewCell.identifier)
        collectionViewSuggestion.backgroundColor = UIColor.clear
        
        /*addSubview(collectionViewSuggestion)
        
        NSLayoutConstraint.activate([
            collectionViewSuggestion.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionViewSuggestion.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewSuggestion.topAnchor.constraint(equalTo: topAnchor),
            collectionViewSuggestion.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])*/
    }
    func setDataArray(_ dataArray: [Response]) {
        self.dataArray = dataArray
        collectionViewSuggestion.reloadData()
    
    }
}

extension SuggestionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestionCollectionViewCell.identifier, for: indexPath) as! SuggestionCollectionViewCell
        let data = dataArray[indexPath.item]
        switch data.template {
        case .cell_suggestion:
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
