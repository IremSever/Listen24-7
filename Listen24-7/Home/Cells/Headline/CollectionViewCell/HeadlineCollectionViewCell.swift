//
//  HeadlineCollectionViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class HeadlineCollectionViewCell: UICollectionViewCell {
    static let identifier = "HeadlineCollectionViewCell"
    @IBOutlet weak var pageControlHeadline: UIPageControl!
    @IBOutlet weak var lblHeadlineTitle: UILabel!
    @IBOutlet weak var imgHeadline: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
