//
//  TableViewCell.swift
//  Listen24-7
//
//  Created by IREM SEVER on 20.03.2024.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {
    
    static let identifier = "PlaylistTableViewCell"
    
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblSong: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        lblSong.font = UIFont(name: "Futura-Bold", size: 13)
        lblSong.textColor = UIColor.systemPurple
        
        lblArtist.font = UIFont(name: "Futura", size: 10)
        lblArtist.textColor = UIColor.gray
        
        lblDuration.font = UIFont(name: "Futura", size: 10)
        lblDuration.textColor = UIColor.gray
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
    }
    
    func configure(with song: PlaylistSongs?) {
        guard let song = song else { return }
        lblSong.text = song.name ?? "Unknown Song"
        if let artist = song.singers?.first?.name {
            lblArtist.text = artist
        } else {
            lblArtist.text = "Unknown Artist"
        }
        lblDuration.text = song.durationTime ?? "Unknown Duration"
    }
}

