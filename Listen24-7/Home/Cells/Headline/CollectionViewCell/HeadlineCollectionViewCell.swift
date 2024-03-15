//
//  HeadlineCollectionViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class HeadlineCollectionViewCell: UICollectionViewCell {
    static let identifier = "HeadlineCollectionViewCell"
    @IBOutlet weak var lblHeadlineTitle: UILabel!
    @IBOutlet weak var imgHeadline: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imgHeadline?.contentMode = .scaleAspectFill
        imgHeadline?.layer.cornerRadius = 20
        imgHeadline?.clipsToBounds = true
        lblHeadlineTitle?.font = UIFont(name: "Futura-Bold", size: 15)
        lblHeadlineTitle?.textColor = UIColor.white
        lblHeadlineTitle?.layer.shadowColor = UIColor.black.cgColor
        lblHeadlineTitle?.layer.shadowOpacity = 0.5
        lblHeadlineTitle?.layer.shadowOffset = CGSize(width: 2, height: 2)
        lblHeadlineTitle?.layer.shadowRadius = 2
    }
    
    func configure(with data: Info) {
        guard let imageName = data.image, let image = UIImage(named: imageName) else {
            print("Image couldn't be loaded.")
            return
        }
        imgHeadline?.image = image
        lblHeadlineTitle?.text = data.title
    }
}


