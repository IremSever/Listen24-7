//
//  HeadlineTableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

protocol headlineCellProtocol {
    func didSelectedHeadline(with id: Int)
}

class HeadlineTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    @IBOutlet weak var pageControlHeadline: UIPageControl!
    @IBOutlet weak var collectionViewHeadline: UICollectionView!
    static let identifier = "HeadlineTableViewCell"
    var dataArray: [News] = [] {
        didSet {
            collectionViewHeadline.reloadData()
            //pageControlHeadline.numberOfPages = dataArray.first?.response?.count ?? 0
        }
    }
    var selectedPlaylistId: Int?
    var delegate: headlineCellProtocol?
    var frameValue: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createHeadlineCollectionView()
       // pageControlHeadline.numberOfPages = dataArray.first?.response?.count ?? 0
    }
    
    func createHeadlineCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 700, height: 500)
        collectionViewHeadline.collectionViewLayout = layout
        collectionViewHeadline.register(UINib(nibName: "HeadlineCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: HeadlineCollectionViewCell.identifier)
        collectionViewHeadline.backgroundColor = .clear
        collectionViewHeadline.delegate = self
        collectionViewHeadline.dataSource = self
        collectionViewHeadline.showsHorizontalScrollIndicator = false
        collectionViewHeadline.isPagingEnabled = false
    }
    
    func updateDataArray(with dataArray: [News]) {
        self.dataArray = dataArray
        collectionViewHeadline.reloadData()
       // pageControlHeadline.numberOfPages = dataArray.first?.response?.count ?? 0
        if dataArray.first?.response?.count ?? 0 > 0 {
            let selectedIndexPath = IndexPath(row: selectedPlaylistId ?? 0, section: 0)
            collectionViewHeadline.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
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
        
        let nextIndex = (currentIndex + 1) % totalItems
        let nextCell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCollectionViewCell.identifier, for: IndexPath(item: nextIndex, section: 0)) as! HeadlineCollectionViewCell
        if let item = dataArray.first?.response?[nextIndex] {
            nextCell.configure(with: item)
        }
        
        return cell
    }
    
    func extractId(from external: String?) -> Int? {
        guard let external = external else {
            return nil
        }
        
        let prefix = "playlist://"
        guard external.hasPrefix(prefix) else {
            return nil
        }
        
        let idString = String(external.dropFirst(prefix.count))
        return Int(idString)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedPlaylistId = dataArray.first?.response?[indexPath.row].external,
              let id = extractId(from: selectedPlaylistId) else {
            return
        }
        delegate?.didSelectedHeadline(with: id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 80, height: 470)
    }
    
  /*  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let currentPage = Int(scrollView.contentOffset.x / pageWidth)
        //  pageControlHeadline.currentPage = currentPage
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let pageWidth = scrollView.frame.size.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        let pageCount = dataArray.first?.response?.count ?? 0
        
        if currentPage == 0 {
            let lastPageIndex = pageCount - 1
            pageControlHeadline.currentPage = lastPageIndex
            let lastItemIndex = IndexPath(item: lastPageIndex, section: 0)
            collectionViewHeadline.scrollToItem(at: lastItemIndex, at: .centeredHorizontally, animated: true)
        } else if currentPage == pageCount {
            pageControlHeadline.currentPage = 0
            collectionViewHeadline.contentOffset = CGPoint(x: 0, y: 0)
        } else {
            pageControlHeadline.currentPage = currentPage
        }
    }*/
}

