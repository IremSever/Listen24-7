//
//  SquareCollectionViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class SquareCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgSquare: UIImageView!
    static let identifier = "SquareCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgSquare?.frame = contentView.bounds
        imgSquare?.layer.cornerRadius = 20
        imgSquare?.clipsToBounds = true
    }
    
    func configure(with data: Info) {
        guard let imageName = data.image, let image = UIImage(named: imageName) else {
            print("Image couldn't be loaded.")
            return
        }
        imgSquare?.image = image
    }
    
}
