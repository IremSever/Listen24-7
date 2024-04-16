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
        if let playlistResponse = playlistResponse {
            lblSong.text = playlistResponse.songs.album
            lblSong.font = UIFont(name: "Futura-Bold", size: 10)
            lblSong.textColor = UIColor.systemPurple
            
            lblArtist.text = playlistResponse.durationTime
            lblArtist.font = UIFont(name: "Futura", size: 8)
            lblArtist.textColor = UIColor.gray
            
            lblDuration.text = playlistResponse.durationTime
            lblDuration.font = UIFont(name: "Futura", size: 8)
            lblDuration.textColor = UIColor.gray
        }
    }
}

