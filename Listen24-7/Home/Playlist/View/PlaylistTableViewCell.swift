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
    }
    
    func configure(with playlistResponse: PlaylistResponse?) {
        if let playlistResponse = playlistResponse, let firstSong = playlistResponse.songs?.first {
            lblSong.text = firstSong.name
            lblSong.font = UIFont(name: "Futura-Bold", size: 10)
            lblSong.textColor = UIColor.systemPurple
            
            lblArtist.text = firstSong.singers?.name
            lblArtist.font = UIFont(name: "Futura", size: 8)
            lblArtist.textColor = UIColor.gray
            
            lblDuration.text = firstSong.durationTime
            lblDuration.font = UIFont(name: "Futura", size: 8)
            lblDuration.textColor = UIColor.gray
        }
    }

}

