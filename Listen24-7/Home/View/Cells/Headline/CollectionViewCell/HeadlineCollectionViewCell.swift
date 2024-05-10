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
        lblHeadlineTitle?.font = UIFont(name: "Futura-Bold", size: 17)
        lblHeadlineTitle?.textColor = UIColor.white
        lblHeadlineTitle?.layer.shadowColor = UIColor.black.cgColor
        lblHeadlineTitle?.layer.shadowOpacity = 0.5
        lblHeadlineTitle?.layer.shadowOffset = CGSize(width: 2, height: 2)
        lblHeadlineTitle?.layer.shadowRadius = 2
        imgHeadline?.contentMode = .scaleAspectFill
        imgHeadline?.layer.cornerRadius = 20
        imgHeadline?.clipsToBounds = true
    }
    
    func configure(with data: HeaderResponse?) {
        guard let imageURLString = data?.image,
              let imageURL = URL(string: imageURLString) else {
            imgHeadline.image = nil
            lblHeadlineTitle.text = nil
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
            guard let self = self, let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imgHeadline.image = image
            }
        }.resume()
        
        lblHeadlineTitle?.text = data?.title
    }
}
