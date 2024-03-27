//
//  SuggestionCollectionViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class SuggestionCollectionViewCell: UICollectionViewCell {

    static let identifier = "SuggestionCollectionViewCell"
    @IBOutlet weak var lbRecordName: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var imgCover: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 50
        contentView.clipsToBounds = true
        
        imgCover?.contentMode = .scaleAspectFill
        imgCover?.layer.cornerRadius = 5
        imgCover?.clipsToBounds = true
        
        lbRecordName?.font = UIFont(name: "Futura-Bold", size: 12)
        lbRecordName?.textColor = UIColor.white
        
        lblReleaseDate?.font = UIFont(name: "Futura", size: 9)
        lblReleaseDate?.textColor = UIColor.systemGray2
    }
    
    func configure(with data: Song) {
        guard let imageName = data.image, let image = UIImage(named: imageName) else {
            print("Image couldn't be loaded.")
            return
        }
        imgCover?.image = image
        lbRecordName?.text = data.name
        lblReleaseDate?.text = data.publishDate
    }
    
    private func getImageDataFrom(url: URL, forCell cellNumber: Int) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Suggestion Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    if cellNumber == 1 {
                        self.imgCover.image = image
                    }
                }
            }
        }.resume()
    }
}
