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
    
    func configure(with data: Info) {
        if let imageName = data.image {
            imgSquare.image = UIImage(named: imageName)
            imgSquare.layer.cornerRadius = 10
            imgSquare.clipsToBounds = true
        } else {
            print("didn't find configure")
        }
    }
}


