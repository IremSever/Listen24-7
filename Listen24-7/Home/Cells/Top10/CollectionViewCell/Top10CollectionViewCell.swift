//
//  Top10CollectionViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class Top10CollectionViewCell: UICollectionViewCell {
    static let identifier = "Top10CollectionViewCell"

    @IBOutlet weak var lblSingerName: UILabel!
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var lblListNo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with data: Info) {
        lblListNo.text = data.listNo
        lblListNo.font = UIFont(name: "Futura-Bold", size: 20)
        lblListNo.textColor = UIColor.black
        
        lblSingerName.text = data.artist
        lblSingerName.font = UIFont(name: "Futura", size: 10)
        lblSingerName.textColor = UIColor.black
        
        lblSongName.text = data.title
        lblSongName.font = UIFont(name: "Futura-Bold", size: 13)
        lblSongName.textColor = UIColor.black
    }
}

