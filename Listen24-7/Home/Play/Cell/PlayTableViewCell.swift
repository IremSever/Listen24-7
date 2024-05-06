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
    @IBOutlet weak var lblTimeTotal: UILabel!
    @IBOutlet weak var lblTimeElapsed: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblName.font = UIFont(name: "Futura-Bold", size: 13)
        lblName.textColor = UIColor.systemPurple
        
        lblArtist.font = UIFont(name: "Futura", size: 10)
        lblArtist.textColor = UIColor.gray
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let screenSize = UIScreen.main.bounds.size
        let topMargin: CGFloat = 0.08 * screenSize.height
        let sideMargin: CGFloat = 0.02 * screenSize.width
        
        let margins = UIEdgeInsets(top: topMargin, left: sideMargin, bottom: topMargin, right: sideMargin)
        contentView.frame = bounds.inset(by: margins)
    }
    
    func configure(with data: PlaylistSongs?) {
        guard let playlist = data?.playlists?.first,
              let imageURLString = playlist.image,
              let imageURL = URL(string: imageURLString) else {
            imgSong.image = nil
            lblName.text = nil
            lblArtist.text = nil
            lblTimeTotal.text = nil
            lblTimeElapsed.text = nil
            return
        }
        
        lblTimeTotal.text = data?.durationTime
        lblTimeElapsed.text = "00:00"
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
            guard let self = self, let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imgSong.image = image
            }
        }.resume()
    }

}
