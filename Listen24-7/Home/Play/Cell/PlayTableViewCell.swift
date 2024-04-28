//
//  PlayTableViewCell.swift
//  Listen24-7
//
//  Created by İrem Sever on 28.04.2024.
//

import UIKit

class PlayTableViewCell: UITableViewCell {
    static let identifier = "PlayTableViewCell"
    @IBOutlet weak var sliderSong: UISlider!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var buttonPrevious: UIButton!
    @IBOutlet weak var imgSong: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
