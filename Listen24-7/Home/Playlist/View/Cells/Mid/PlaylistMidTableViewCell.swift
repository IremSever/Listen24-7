//
//  PlaylistMidTableViewCell.swift
//  Listen24-7
//
//  Created by İrem Sever on 25.04.2024.
//

import UIKit

class PlaylistMidTableViewCell: UITableViewCell {
    static let identifier = "PlaylistMidTableViewCell"
    @IBOutlet weak var lblTitlePlaylist: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .lightGray
        lblTitlePlaylist.font = UIFont(name: "Futura-Bold", size: 17)
        lblTitlePlaylist.textColor = UIColor.black
    }
    
    func configure(with data: PlaylistResponse?){
        lblTitlePlaylist?.text = data?.name
    }
}
