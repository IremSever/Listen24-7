//
//  SuggestionTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit
protocol suggestionCellProtocol {
    func didSelectedSuggestion(with id: Int)
}


class SuggestionTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
   
    static let identifier = "SuggestionTableViewCell"
    
    @IBOutlet weak var collectionViewSuggestion: UICollectionView!
    
    var dataArray: [Response] = []
    var delegate: suggestionCellProtocol?
    
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
        collectionViewSuggestion.delegate = self
        collectionViewSuggestion.dataSource = self
        collectionViewSuggestion.showsHorizontalScrollIndicator = false
    }
    
    func updateDataArray(with dataArray: Response) {
        self.dataArray = [dataArray]
        collectionViewSuggestion.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.first?.songs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestionCollectionViewCell.identifier, for: indexPath) as! SuggestionCollectionViewCell
        if let item = dataArray.first?.songs?[indexPath.row] {
            cell.configure(with: item)
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedPlaylistId = dataArray.first?.playlists?[indexPath.row].id else {
            return
        }
        self.delegate?.didSelectedSuggestion(with: selectedPlaylistId)
        return
    }

    
}

