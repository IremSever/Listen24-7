//
//  LatestCollectionViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class LatestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblMinutes: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    static let identifier = "LatestCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with data: Info) {
        if let imageName = data.image {
            imgCover.image = UIImage(named: imageName)
            imgCover.layer.cornerRadius = 10
            imgCover.clipsToBounds = true
        } else {
            print("Image name not found")
        }
        
        lblTitle.text = data.title
        lblTitle.font = UIFont(name: "Futura-Bold", size: 10)
        lblTitle.textColor = UIColor.black
        
        lblMinutes.text = data.duration
        lblMinutes.font = UIFont(name: "Futura", size: 8)
        lblMinutes.textColor = UIColor.black
    }
}

