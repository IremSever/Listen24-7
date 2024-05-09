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
    
    
    @IBOutlet weak var sliderSong: UISlider!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var imgBlack: UIImageView!
    @IBOutlet weak var lblTimeElapsed: UILabel!
    @IBOutlet weak var lblTimeTotal: UILabel!
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
    
    var timeObserverToken: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonBack?.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        if let selectedIndex = selectedIndex, let selectedSong = listForPlayer.first?.songs?[selectedIndex] {
            configure(with: selectedSong)
            styleController()
            prepareSong()
            
        }
        
        sliderSong.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        sliderSong?.isContinuous = true
        player?.play()
        //print("items: ", selectedIndex , listForPlayer)
        //print("mp3 url: ", listForPlayer.first?.songs?[selectedIndex ?? 0].mp3URL)
        
        addTimeObserver()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
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
            resetElapsedTimeAndSlider()
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
            resetElapsedTimeAndSlider()
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        guard let player = player else { return }
        
        if player.status == .readyToPlay {
            let newValue = sender.value
            let duration = player.currentItem?.duration.seconds ?? 0
            let newTime = CMTime(seconds: duration * Double(newValue), preferredTimescale: 1)
            
            player.seek(to: newTime)
            player.play()
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
        
        //let thumbImage = UIImage(named: "sliderThumbTint")
        //sliderSong.setThumbImage(thumbImage, for: .normal)
        sliderSong.thumbTintColor = UIColor.systemPurple
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
    
    func addTimeObserver() {
        guard let player = player else { return }
        
        let interval = CMTime(seconds: 1, preferredTimescale: 1)
        
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { [weak self] time in
            guard let self = self else { return }
            let currentTime = Int(CMTimeGetSeconds(time))
            let minutes = currentTime / 60
            let seconds = currentTime % 60
            self.lblTimeElapsed.text = String(format: "%02d:%02d", minutes, seconds)
            
            guard let duration = self.player?.currentItem?.duration else { return }
            let durationSeconds = CMTimeGetSeconds(duration)
            self.sliderSong.value = Float(currentTime) / Float(durationSeconds)
        }
    }
    
    func resetElapsedTimeAndSlider() {
        lblTimeElapsed.text = "00:00"
        sliderSong.value = 0
        addTimeObserver()
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        var selectedIndex: Int? = 0
        
        var newIndex = (selectedIndex ?? 0) + 1
        
        if newIndex >= (listForPlayer.first?.songs?.count ?? 1) {
            newIndex = 0
        }
        
        if let selectedSong = listForPlayer.first?.songs?[newIndex] {
            selectedIndex = newIndex
            configure(with: selectedSong)
            prepareSong()
            player?.play()
            resetElapsedTimeAndSlider()
        }
    }
}


