//
//  PlayViewController.swift
//  Listen24-7
//
//  Created by İrem Sever on 24.04.2024.
//

import Foundation
import UIKit
class PlayViewController: UIViewController {
    
    static let identifier = "PlayViewController"
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var imgBlack: UIImageView!
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
        buttonBack?.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        if let selectedIndex = selectedIndex, let selectedSong = listForPlayer.first?.songs?[selectedIndex] {
            configure(with: selectedSong)
            
            
        }
        print("items: ", selectedIndex , listForPlayer)
        print("mp3 url: ", listForPlayer.first?.songs?[selectedIndex ?? 0].mp3URL)
        
        styleController()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func configure(with data: PlaylistSongs) {
        guard let imageURLString = data.playlists?.first?.image,
              let imageURL = URL(string: imageURLString) else {
            imgSong?.image = nil
            lblName.text = nil
            lblArtist.text = nil
            lblTimeTotal.text = nil
            lblTimeElapsed.text = nil
            return
        }
        
        lblName.text = data.name
        lblArtist.text = data.singers?.first?.name
        lblTimeTotal.text = data.durationTime
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
    
    func styleController() {
        lblName?.font = UIFont(name: "Futura-Bold", size: 15)
        lblName?.textColor = UIColor.systemPurple
        
        lblArtist?.font = UIFont(name: "Futura", size: 12)
        lblArtist?.textColor = UIColor.gray
        
        lblTimeElapsed?.font = UIFont(name: "Futura", size: 10)
        lblTimeElapsed?.textColor = UIColor.gray
        
        lblTimeTotal?.font = UIFont(name: "Futura", size: 10)
        lblTimeTotal?.textColor = UIColor.gray
        
        imgSong.layer.cornerRadius = 20
        imgBlack.layer.cornerRadius = 20
    }
}




