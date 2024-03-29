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
        imgCircle?.layer.cornerRadius = 47
        imgCircle?.clipsToBounds = true
    }
    
    func configure(with data: RadioChannel?) {
        guard let imageURLString = data?.image,
              let imageURL = URL(string: imageURLString) else {
            imgCircle.image = nil
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
            guard let self = self, let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imgCircle.image = image
            }
        }.resume()
    }
}
