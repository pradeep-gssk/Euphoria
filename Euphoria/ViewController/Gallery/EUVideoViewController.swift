//
//  EUVideoViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/12/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import AVKit

class EUVideoViewController: UIViewController {
    
    var video: Video?
    var player: AVPlayer?
    var avPlayerViewController: AVPlayerViewController?

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videDescriptionLabel: UITextView!
    @IBOutlet weak var videoContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.titleLabel.text = self.video?.title
        self.videoTitleLabel.text = self.video?.videoName
        self.videDescriptionLabel.text = self.video?.videoDescription
        
        if let url = video?.videoUrl {
            let playerItem: AVPlayerItem = AVPlayerItem(url: url)
            self.player = AVPlayer(playerItem: playerItem)
            let playerVC = AVPlayerViewController()
            playerVC.player = self.player
            
            self.addChild(playerVC)
            self.videoContainer.addSubview(playerVC.view)
            playerVC.view.frame = self.videoContainer.bounds
            
            self.avPlayerViewController = playerVC
            self.player?.play()
        }
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
