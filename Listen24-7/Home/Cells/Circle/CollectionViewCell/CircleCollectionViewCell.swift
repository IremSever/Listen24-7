//
//  CircleCollectionViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class CircleCollectionViewCell: UICollectionViewCell {
    static let identifier = "CircleCollectionViewCell"
    @IBOutlet weak var imgCircle: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with data: Info) {
        if let imageName = data.image {
            imgCircle.image = UIImage(named: imageName)
            imgCircle.layer.cornerRadius = imgCircle.frame.size.width / 2
            imgCircle.clipsToBounds = true
        } else {
            print("didnt find configure")
        }
    }

}
