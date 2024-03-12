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
        
        lbRecordName.text = data.title
        lbRecordName.font = UIFont(name: "Futura-Bold", size: 13)
        lbRecordName.textColor = UIColor.white
        
        lblReleaseDate.text = data.title
        lblReleaseDate.font = UIFont(name: "Futura", size: 10)
        lblReleaseDate.textColor = UIColor.white
    }
}
