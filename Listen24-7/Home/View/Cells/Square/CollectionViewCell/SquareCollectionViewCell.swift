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
    
    func configure(with data: CategoryGroup) {
        guard let urlString = data.image, let imageURL = URL(string: urlString) else {
            self.imgSquare.image = UIImage(named: "noImageAvailable")
            return
        }
        self.imgSquare.image = nil
        getImageDataFrom(url: imageURL, forCell: 1)
    }
    
    private func getImageDataFrom(url: URL, forCell cellNumber: Int) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Headline Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    if cellNumber == 1 {
                        self.imgSquare.image = image
                    }
                }
            }
        }.resume()
    }
}
