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
    var dataArray: [News] = []
    var selectedIndexPath: IndexPath?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createHeadlineCollectionView()
    }
    
    func createHeadlineCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 350, height: 500)
        collectionViewHeadline.collectionViewLayout = layout
        collectionViewHeadline.register(UINib(nibName: "HeadlineCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: HeadlineCollectionViewCell.identifier)
        collectionViewHeadline.backgroundColor = .clear
        collectionViewHeadline.delegate = self
        collectionViewHeadline.dataSource = self
        collectionViewHeadline.showsHorizontalScrollIndicator = false
        collectionViewHeadline.isPagingEnabled = true
        
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = screenWidth - 100
        let horizontalInset = (screenWidth - cellWidth) / 2
        collectionViewHeadline.contentInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
    }
    
    func updateDataArray(with dataArray: [News]) {
        self.dataArray = dataArray
        collectionViewHeadline.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataArray.first?.response?.count ?? 0) * 1000 // Büyük bir sayıda hücre oluşturarak sonsuz döngü sağlanacak
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCollectionViewCell.identifier, for: indexPath) as! HeadlineCollectionViewCell
        let dataIndex = indexPath.row % (dataArray.first?.response?.count ?? 1) // Veri dizisi döngüsü için indeks hesapla
        if let item = dataArray.first?.response?[dataIndex] {
            cell.configure(with: item)
        }
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = screenWidth - 100
        let itemCount = dataArray.first?.response?.count ?? 1
        
        if scrollView.contentOffset.x <= 0 {
            scrollView.contentOffset = CGPoint(x: CGFloat((dataArray.first?.response?.count ?? 0) * 999) * itemWidth, y: 0)
        } else if scrollView.contentOffset.x >= CGFloat((dataArray.first?.response?.count ?? 0) * 1000 - 1) * itemWidth {
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
        }
        
        let centerPoint = CGPoint(x: scrollView.contentOffset.x + (scrollView.bounds.width / 2), y: (scrollView.bounds.height / 2))
        if let indexPath = collectionViewHeadline.indexPathForItem(at: centerPoint) {
            selectedIndexPath = indexPath
        }
    }
}
