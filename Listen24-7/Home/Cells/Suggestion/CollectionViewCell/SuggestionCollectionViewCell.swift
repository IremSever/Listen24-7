//
//  SuggestionCollectionViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class SuggestionCollectionViewCell: UICollectionViewCell {

    static let identifier = "SuggestionCollectionViewCell"
    @IBOutlet weak var lbRecordName: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var imgCover: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgCover?.frame = contentView.bounds
        imgCover?.layer.cornerRadius = 20
        imgCover?.clipsToBounds = true
    }
    
    func configure(with data: Info) {
        guard let imageName = data.image, let image = UIImage(named: imageName) else {
            print("Image couldn't be loaded.")
            return
        }
        
        imgCover?.image = image
    }
}
