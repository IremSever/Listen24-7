//
//  HeadlineTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

protocol headlineCellProtocol {
    func didSelectedHeadline(with id: String)
}

class HeadlineTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    @IBOutlet weak var pageControlHeadline: UIPageControl!
    @IBOutlet weak var collectionViewHeadline: UICollectionView!
    static let identifier = "HeadlineTableViewCell"
    var dataArray: [News] = [] {
        didSet {
            collectionViewHeadline.reloadData()
            pageControlHeadline.numberOfPages = dataArray.first?.response?.count ?? 0
        }
    }
    var selectedPlaylistId: Int?
    var delegate: headlineCellProtocol?
    var frameValue: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createHeadlineCollectionView()
        pageControlHeadline.numberOfPages = dataArray.first?.response?.count ?? 0
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
    }
    
    func updateDataArray(with dataArray: [News]) {
        self.dataArray = dataArray
        collectionViewHeadline.reloadData()
        pageControlHeadline.numberOfPages = dataArray.first?.response?.count ?? 0
        if dataArray.first?.response?.count ?? 0 > 0 {
            let selectedIndexPath = IndexPath(row: selectedPlaylistId ?? 0, section: 0)
            collectionViewHeadline.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    /*func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
     let itemWidth = collectionViewHeadline.frame.width
     let currentIndex = Int(collectionViewHeadline.contentOffset.x / itemWidth)
     pageControlHeadline.currentPage = currentIndex
     selectedIndex = currentIndex
     
     }*/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.first?.response?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCollectionViewCell.identifier, for: indexPath) as! HeadlineCollectionViewCell
        let currentIndex = indexPath.row
        let totalItems = dataArray.first?.response?.count ?? 0
        if let item = dataArray.first?.response?[currentIndex % totalItems] {
            cell.configure(with: item)
            
            if let playlistId = item.id {
                self.selectedPlaylistId = Int(playlistId)
            } else {
                self.selectedPlaylistId = nil
            }
        }
        
        let previousIndex = (currentIndex + totalItems - 1) % totalItems
        let previousCell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCollectionViewCell.identifier, for: IndexPath(item: previousIndex, section: 0)) as! HeadlineCollectionViewCell
        if let item = dataArray.first?.response?[previousIndex] {
            previousCell.configure(with: item)
        }
        
        // Sonraki hücre
        let nextIndex = (currentIndex + 1) % totalItems
        let nextCell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCollectionViewCell.identifier, for: IndexPath(item: nextIndex, section: 0)) as! HeadlineCollectionViewCell
        if let item = dataArray.first?.response?[nextIndex] {
            nextCell.configure(with: item)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedPlaylistId = dataArray.first?.response?[indexPath.row].id else {
            return
        }
        delegate?.didSelectedHeadline(with: selectedPlaylistId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 490)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControlHeadline.currentPage = Int(pageNumber)
        if pageControlHeadline.currentPage == 1 {
            frameValue = pageNumber
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if pageControlHeadline.currentPage == dataArray.first?.response?.count ?? 0 - 1{
            pageControlHeadline.currentPage = 0
            collectionViewHeadline.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
}


