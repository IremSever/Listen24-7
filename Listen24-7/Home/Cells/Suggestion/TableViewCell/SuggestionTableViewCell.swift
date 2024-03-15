//
//  SuggestionTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class SuggestionTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    static let identifier = "SuggestionTableViewCell"
    
    @IBOutlet weak var collectionViewSuggestion: UICollectionView!
 
    var dataArray: [Response] = []
  
    override func awakeFromNib() {
        super.awakeFromNib()
        createSuggestionCollectionView()
    }
    
    func createSuggestionCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionViewSuggestion.register(UINib(nibName: "SuggestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SuggestionCollectionViewCell.identifier)
        collectionViewSuggestion.backgroundColor = UIColor.clear
        collectionViewSuggestion.dataSource = self
        
        addSubview(collectionViewSuggestion)
    }
    
    func updateDataArray(with dataArray: [Response]) {
        self.dataArray = dataArray
        collectionViewSuggestion.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.first?.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestionCollectionViewCell.identifier, for: indexPath) as! SuggestionCollectionViewCell
        if let data = dataArray.first?.list?[indexPath.item] {
            cell.configure(with: data)
        }
        return cell
    }
}
