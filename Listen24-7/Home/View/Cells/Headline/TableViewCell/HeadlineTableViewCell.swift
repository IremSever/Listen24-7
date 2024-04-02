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
    var timer: Timer?
    var currentIndex = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        createHeadlineCollectionView()
        startAutoScroll()
    }

    func createHeadlineCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: collectionViewHeadline.frame.width, height: collectionViewHeadline.frame.height)
        collectionViewHeadline.collectionViewLayout = layout
        collectionViewHeadline.register(UINib(nibName: "HeadlineCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: HeadlineCollectionViewCell.identifier)

        collectionViewHeadline.backgroundColor = UIColor.clear
        collectionViewHeadline.delegate = self
        collectionViewHeadline.dataSource = self
        collectionViewHeadline.showsHorizontalScrollIndicator = false
        collectionViewHeadline.isPagingEnabled = true
    }

    func updateDataArray(with dataArray: [News]) {
        self.dataArray = dataArray
        collectionViewHeadline.reloadData()
    }

    func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }

    @objc func scrollToNextItem() {
        currentIndex = (currentIndex + 1) % (dataArray.first?.response?.count ?? 0)
        let indexPath = IndexPath(item: currentIndex, section: 0)
        collectionViewHeadline.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.first?.response?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCollectionViewCell.identifier, for: indexPath) as! HeadlineCollectionViewCell
        if let item = dataArray.first?.response?[indexPath.row] {
            cell.configure(with: item)
            return cell
        }
        return cell
    }
}
