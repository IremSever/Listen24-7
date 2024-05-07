//
//  PlayViewController.swift
//  Listen24-7
//
//  Created by İrem Sever on 24.04.2024.
//

import Foundation
import UIKit
class PlayViewController: UIViewController {
    
    
    @IBOutlet weak var tableViewPlay: UITableView!
    @IBOutlet weak var buttonBack: UIButton!
    static let identifier = "PlayViewController"
    
    @IBOutlet weak var lblTimeElapsed: UILabel!
    @IBOutlet weak var lblTimeTotal: UILabel!
    @IBOutlet weak var buttonBackward: UIButton!
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var buttonForward: UIButton!
    @IBOutlet weak var sliderSong: UISlider!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgSong: UIImageView!
    
    var viewModel = PlaylistViewModel()
    var selectedPlaylistSongs: [PlaylistSongs]?
    var selectedPlaylistId: Int?
    
    var listForPlayer: [PlaylistResponse] = []
    var selectedIndex: Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonBack.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        print("items: ", selectedIndex , listForPlayer)
        print("mp3 url: ", listForPlayer.first?.songs?[selectedIndex ?? 0].mp3URL)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblName?.font = UIFont(name: "Futura-Bold", size: 13)
        lblName?.textColor = UIColor.systemPurple
        
        lblArtist?.font = UIFont(name: "Futura", size: 10)
        lblArtist?.textColor = UIColor.gray
        
        
    }
    func configure(with data: PlaylistSongs?) {
        guard let playlist = data?.playlists?.first,
              let imageURLString = playlist.image,
              let imageURL = URL(string: imageURLString) else {
            imgSong?.image = nil
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
  

