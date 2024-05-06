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
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
    }
    
    func configure(with data: PlaylistResponse?) {
        guard let imageURLString = data?.image,
              let imageURL = URL(string: imageURLString) else {
            imgSong.image = nil
            lblName.text = nil
            lblArtist.text = nil
            lblTimeTotal.text = nil
            lblTimeElapsed.text = nil
            return
        }
        
        lblTimeTotal.text = data?.songs?.first?.durationTime
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
