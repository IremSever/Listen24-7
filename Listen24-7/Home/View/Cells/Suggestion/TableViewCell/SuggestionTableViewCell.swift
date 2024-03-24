//
//  SuggestionTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class SuggestionTableViewCell: UITableViewCell /*, UICollectionViewDataSource, UICollectionViewDelegate*/ {
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
        layout.itemSize = CGSize(width: 250, height: 350)
        layout.minimumLineSpacing = 8
        collectionViewSuggestion.backgroundColor = UIColor.clear
        //collectionViewSuggestion.delegate = self
        //collectionViewSuggestion.dataSource = self
        collectionViewSuggestion.showsHorizontalScrollIndicator = false
    }
    
    func updateDataArray(with dataArray: [Response]) {
        self.dataArray = dataArray
        collectionViewSuggestion.reloadData()
    }
    
    /*func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.first?.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestionCollectionViewCell.identifier, for: indexPath) as! SuggestionCollectionViewCell
        if let item = dataArray.first?.list?[indexPath.row] {
            cell.configure(with: item)
            return cell
        }
        return cell
    }*/
}
