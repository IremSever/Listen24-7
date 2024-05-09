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
    
    func configure(with data: CategoryGroup?) {
        guard let imageURLString = data?.image,
              let imageURL = URL(string: imageURLString) else {
            imgSquare.image = nil
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
            guard let self = self, let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imgSquare.image = image
            }
        }.resume()
    }
}
