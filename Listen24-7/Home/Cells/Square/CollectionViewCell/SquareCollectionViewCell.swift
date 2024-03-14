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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgSquare?.frame = contentView.bounds
        
        self.imgSquare?.layer.cornerRadius = 20
        self.imgSquare?.clipsToBounds = true
        
    }
    
    func configure(with data: Info) {
        guard let imageName = data.image, let image = UIImage(named: imageName) else {
            print("Image couldn't be loaded.")
            return
        }
        self.imgSquare?.image = image
    
        //imgSquare?.image = image
        //imgSquare?.layer.cornerRadius = 10
        //imgSquare?.clipsToBounds = true
    }
}


