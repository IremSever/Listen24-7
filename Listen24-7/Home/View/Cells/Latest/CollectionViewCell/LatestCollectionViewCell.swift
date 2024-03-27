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
    
    func configure(with data: Song) {
        guard let urlString = data.image, let imageURL = URL(string: urlString) else {
            self.imgCover.image = UIImage(named: "noImageAvailable")
            return
        }
        
        self.imgCover.image = nil
        getImageDataFrom(url: imageURL)
        
        imgCover.layer.cornerRadius = 10
        imgCover.clipsToBounds = true
        
        lblTitle.text = data.name
        lblTitle.font = UIFont(name: "Futura-Bold", size: 12)
        lblTitle.textColor = UIColor.black
        
        lblMinutes.text = data.durationTime
        lblMinutes.font = UIFont(name: "Futura", size: 9)
        lblMinutes.textColor = UIColor.black
    }
    
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Latest Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self?.imgCover.image = image
                }
            }
        }.resume()
    }
}
