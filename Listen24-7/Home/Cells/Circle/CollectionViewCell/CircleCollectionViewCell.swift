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
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgCircle?.frame = contentView.bounds
        imgCircle?.layer.cornerRadius = 49.5
        imgCircle?.clipsToBounds = true
    }
    
    func configure(with data: Info) {
        guard let imageName = data.image, let image = UIImage(named: imageName) else {
            print("Image couldn't be loaded.")
            return
        }
        imgCircle?.image = image
    }
}

