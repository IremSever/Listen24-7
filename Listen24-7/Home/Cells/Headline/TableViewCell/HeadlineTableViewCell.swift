//
//  HeadlineTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate  {
    @IBOutlet weak var collectionViewHeadline: UICollectionView!
    static let identifier = "HeadlineTableViewCell"
     var dataArray: [Response] = []
     
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         createHeadlineCollectionView()
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
     }
     
     override func awakeFromNib() {
         super.awakeFromNib()
         createHeadlineCollectionView()
     }
     
     func createHeadlineCollectionView() {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         collectionViewHeadline.register(UINib(nibName: "HeadlineCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: HeadlineCollectionViewCell.identifier)
         collectionViewHeadline.backgroundColor = UIColor.clear
         collectionViewHeadline.dataSource = self
         
         addSubview(collectionViewHeadline)
     }
     
     func updateDataArray(with dataArray: [Response]) {
         self.dataArray = dataArray
         collectionViewHeadline.reloadData()
     }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return dataArray.first?.list?.count ?? 0
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCollectionViewCell.identifier, for: indexPath) as! HeadlineCollectionViewCell
         if let data = dataArray.first?.list?[indexPath.item] {
             cell.configure(with: data)
         }
         return cell
     }
 }
