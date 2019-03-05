//
//  EUExerciseVideoViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/11/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import AVKit

class EUExerciseVideoViewController: UIViewController {

    var exercise: Exercises?
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videDescriptionLabel: UITextView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var videoContainer: VideoContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.titleLabel.text = self.exercise?.exercise
        self.videoTitleLabel.text = self.exercise?.videoName
        self.videDescriptionLabel.text = self.exercise?.videoDescription
        
        if let url = exercise?.videoUrl {
            let playerItem: AVPlayerItem = AVPlayerItem(url: url)
            self.player = AVPlayer(playerItem: playerItem)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = videoContainer.bounds
            self.videoContainer.layer.addSublayer(playerLayer)
            self.videoContainer.playerLayer = playerLayer
            
            slider.minimumValue = 0
            let duration: CMTime = playerItem.asset.duration
            let seconds: Float64 = CMTimeGetSeconds(duration)
            slider.maximumValue = Float(seconds)
            slider.isContinuous = true
            
            self.player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main, using: { (time) in
                
                if let player = self.player, player.currentItem?.status == .readyToPlay {
                    let time = CMTimeGetSeconds(player.currentTime());
                    self.slider.value = Float(time)
                }
            })
            
            self.player?.play()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.pause()
        player = nil
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didChangeSliderValue(_ playbackSlider: UISlider) {
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        self.player?.seek(to: targetTime)
        
        if player?.rate == 0 {
            player?.play()
        }
    }
}
