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
    
    func configure(with data: RadioChannel) {
        guard let urlString = data.image, let imageURL = URL(string: urlString) else {
            self.imgCircle.image = UIImage(named: "noImageAvailable")
            return
        }
        self.imgCircle.image = nil
        getImageDataFrom(url: imageURL, forCell: 1)
    }
    
    private func getImageDataFrom(url: URL, forCell cellNumber: Int) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Circle Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    if cellNumber == 1 {
                        self.imgCircle.image = image
                    }
                }
            }
        }.resume()
    }
}
