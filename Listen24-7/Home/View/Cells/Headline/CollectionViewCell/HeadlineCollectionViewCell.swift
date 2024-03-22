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
        
        /*let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imgHeadline.addGestureRecognizer(tapGesture)
        imgHeadline.isUserInteractionEnabled = true*/
    }
    
    /*@objc func imageTapped() {
        let storyboard = UIStoryboard(name: "Playlist", bundle: nil)
        if let playlistVC = storyboard.instantiateViewController(withIdentifier: "PlaylistViewController") as? PlaylistViewController {
            if let currentVC = UIApplication.shared.windows.first?.rootViewController {
                currentVC.present(playlistVC, animated: true, completion: nil)
            }
        }
    }*/
    
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
        
        imgHeadline?.image = image
        lblHeadlineTitle?.text = data.title
    }
}
