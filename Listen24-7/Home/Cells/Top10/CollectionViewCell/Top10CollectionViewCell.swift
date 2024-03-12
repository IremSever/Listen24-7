//
//  Top10CollectionViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 7.03.2024.
//

import UIKit

class Top10CollectionViewCell: UICollectionViewCell {
    static let identifier = "Top10CollectionViewCell"
    
    @IBOutlet weak var lblSingerName2: UILabel!
    @IBOutlet weak var lblSonName2: UILabel!
    @IBOutlet weak var lblListNo2: UILabel!
    @IBOutlet weak var lblSingerName: UILabel!
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var lblListNo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with data: Info) {
        lblListNo.text = data.title
        lblListNo.font = UIFont(name: "Futura-Bold", size: 20)
        lblListNo.textColor = UIColor.black
        
        lblSingerName.text = data.title
        lblSingerName.font = UIFont(name: "Futura", size: 10)
        lblSingerName.textColor = UIColor.black
        
        lblSongName.text = data.title
        lblSongName.font = UIFont(name: "Futura-Bold", size: 13)
        lblSongName.textColor = UIColor.black
        
        lblListNo2.text = data.title
        lblListNo2.font = UIFont(name: "Futura-Bold", size: 20)
        lblListNo2.textColor = UIColor.black
        
        lblSingerName2.text = data.title
        lblSingerName2.font = UIFont(name: "Futura", size: 10)
        lblSingerName2.textColor = UIColor.black
        
        lblSonName2.text = data.title
        lblSonName2.font = UIFont(name: "Futura-Bold", size: 13)
        lblSonName2.textColor = UIColor.black
    }
}

