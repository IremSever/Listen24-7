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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        imgCover?.contentMode = .scaleAspectFill
        imgCover?.layer.cornerRadius = 5
        imgCover?.clipsToBounds = true
        
        lblTitle?.font = UIFont(name: "Futura-Bold", size: 12)
        lblTitle?.textColor = UIColor.black
        
        lblMinutes?.font = UIFont(name: "Futura", size: 9)
        lblMinutes?.textColor = UIColor.darkGray
        
    }
    
    func configure(with data: Song?) {
        guard let imageURLString = data?.image,
              let imageURL = URL(string: imageURLString) else {
            imgCover.image = nil
            lblMinutes.text = nil
            lblTitle.text = nil
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
        
        lblTitle?.text = data?.name
        lblMinutes.text = data?.durationTime
    }
}
