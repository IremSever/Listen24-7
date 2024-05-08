//
//  PlayViewController.swift
//  Listen24-7
//
//  Created by İrem Sever on 24.04.2024.
//

import Foundation
import UIKit
import AVFoundation

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
    
    var player: AVPlayer?
    var isMusicPaused = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonBack?.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        if let selectedIndex = selectedIndex, let selectedSong = listForPlayer.first?.songs?[selectedIndex] {
            configure(with: selectedSong)
            styleController()
            prepareSong()
            
        }
        
        player?.play()
        //print("items: ", selectedIndex , listForPlayer)
        //print("mp3 url: ", listForPlayer.first?.songs?[selectedIndex ?? 0].mp3URL)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    //music buttons
    @IBAction func buttonBackwardTapped(_ sender: UIButton) {
        if selectedIndex == nil {
            selectedIndex = 0
        }
        
        var newIndex = selectedIndex! - 1
        
        if newIndex < 0 {
            newIndex = (listForPlayer.first?.songs?.count ?? 1) - 1
        }
        
        if let selectedSong = listForPlayer.first?.songs?[newIndex] {
            selectedIndex = newIndex
            configure(with: selectedSong)
            prepareSong()
            player?.play()
        }
    }
    
    @IBAction func buttonPlayTapped(_ sender: UIButton) {
        guard let player = player else {
                return
            }
            
            if player.timeControlStatus == .playing {
                sender.setImage(UIImage(named: "play"), for: .normal)
                player.pause()
                isMusicPaused = true
            } else {
                sender.setImage(UIImage(named: "pause"), for: .normal)
                player.play()
                isMusicPaused = false
            }
        }
    
    @IBAction func buttonForwardTapped(_ sender: UIButton) {
        if selectedIndex == nil {
            selectedIndex = 0
        }
        
        var newIndex = selectedIndex! + 1
        
        if newIndex >= (listForPlayer.first?.songs?.count ?? 1) {
            newIndex = 0
        }
        
        if let selectedSong = listForPlayer.first?.songs?[newIndex] {
            selectedIndex = newIndex
            configure(with: selectedSong)
            prepareSong()
            player?.play()
        }
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
    
    func prepareSong() {
        guard let selectedIndex = selectedIndex,
              let selectedSong = listForPlayer.first?.songs?[selectedIndex],
              let mp3URLString = selectedSong.mp3URL,
              let mp3URL = URL(string: mp3URLString) else {
            
            print("Error preparing song")
            return
        }
        
        player = AVPlayer(url: mp3URL)
    }
}


