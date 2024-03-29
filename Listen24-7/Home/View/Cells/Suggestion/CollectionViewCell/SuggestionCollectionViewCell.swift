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
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 50
        contentView.clipsToBounds = true
        
        imgCover?.contentMode = .scaleAspectFill
        imgCover?.layer.cornerRadius = 5
        imgCover?.clipsToBounds = true
        
        lbRecordName?.font = UIFont(name: "Futura-Bold", size: 12)
        lbRecordName?.textColor = UIColor.white
        
        lblReleaseDate?.font = UIFont(name: "Futura", size: 9)
        lblReleaseDate?.textColor = UIColor.systemGray2
    }
    
    func configure(with data: Song?) {
        guard let imageURLString = data?.image,
              let imageURL = URL(string: imageURLString) else {
            imgCover.image = nil
            lblReleaseDate.text = nil
            lbRecordName.text = nil
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
            guard let self = self, let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imgCover.image = image
            }
        }.resume()
        
        lbRecordName?.text = data?.name
        lblReleaseDate?.text = data?.publishDate
    }
}
