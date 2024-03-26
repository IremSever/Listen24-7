//
//  HeadlineCollectionViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class HeadlineCollectionViewCell: UICollectionViewCell {
    static let identifier = "HeadlineCollectionViewCell"
    @IBOutlet weak var lblHeadlineTitle: UILabel!
    @IBOutlet weak var imgHeadline: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgHeadline?.contentMode = .scaleAspectFill
        imgHeadline?.layer.cornerRadius = 20
        imgHeadline?.clipsToBounds = true
        lblHeadlineTitle?.font = UIFont(name: "Futura-Bold", size: 20)
        lblHeadlineTitle?.textColor = UIColor.white
        lblHeadlineTitle?.layer.shadowColor = UIColor.black.cgColor
        lblHeadlineTitle?.layer.shadowOpacity = 0.5
        lblHeadlineTitle?.layer.shadowOffset = CGSize(width: 2, height: 2)
        lblHeadlineTitle?.layer.shadowRadius = 2
    }
    
    func configure(with data: HeaderResponse) {
        guard let urlString = data.image, let imageURL = URL(string: urlString) else {
            self.imgHeadline.image = UIImage(named: "noImageAvailable")
            return
        }
        
        self.imgHeadline.image = nil
        getImageDataFrom(url: imageURL, forCell: 1)
        
        lblHeadlineTitle?.text = data.title
    }
    
    private func getImageDataFrom(url: URL, forCell cellNumber: Int) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle Headline Data
                print("Headline Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    if cellNumber == 1 {
                        self.imgHeadline.image = image
                    }
                }
            }
        }.resume()
    }
}

