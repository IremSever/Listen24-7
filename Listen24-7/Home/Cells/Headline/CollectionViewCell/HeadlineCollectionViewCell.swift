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
        // Initialization code
    }
    
    func configure(with data: Info) {
        guard let imageName = data.image, let image = UIImage(named: imageName) else {
            print("Image couldn't be loaded.")
            return
        }
        imgHeadline?.image = image
        imgHeadline?.contentMode = .scaleAspectFill // Resmin içeriğin tamamını kaplayacak şekilde boyutlandırılmasını sağlar
        imgHeadline?.layer.cornerRadius = 20
        imgHeadline?.clipsToBounds = true
        print("Data image name: \(String(describing: data.image))")
        
        lblHeadlineTitle.text = data.title
        lblHeadlineTitle.font = UIFont(name: "Futura-Bold", size: 15)
        lblHeadlineTitle.textColor = UIColor.white
        
        lblHeadlineTitle.layer.shadowColor = UIColor.black.cgColor
        lblHeadlineTitle.layer.shadowOpacity = 0.5
        lblHeadlineTitle.layer.shadowOffset = CGSize(width: 2, height: 2)
        lblHeadlineTitle.layer.shadowRadius = 2
    }
    
    
}


