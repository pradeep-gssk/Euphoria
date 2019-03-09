//
//  EUTimerCountDownViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/12/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import AVFoundation

class EUTimerCountDownViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var timerImageView: UIImageView!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerTitle: UILabel!
    
    let color = UIColor.color(red: 140, green: 56, blue: 47, alpha: 1)
    let shapeLayer = CAShapeLayer()
    var timer = Timer()
    var seconds: CGFloat = 0.0
    var session: Session!
    var isPaused = true
    var player: AVAudioPlayer?
    
    var stops: [Stop] = []
    
    var stopTime: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.resetValues()
    }
    
    func resetValues() {
        self.stopTimer()
        self.stopButton.isEnabled = false
        self.stopTime = 0
        self.seconds = 0
        self.stops = self.session.stops?.allObjects as? [Stop] ?? []
        self.stops.sort { (stop1, stop2) -> Bool in
            return stop1.index < stop2.index
        }
        self.setSoundPlayTime()
    }
    
    func setSoundPlayTime() {
        self.stopTime += CGFloat(self.stops.first?.time ?? 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.drawShapeLayer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopTimer()
    }
    
    private func stopTimer() {
        self.timer.invalidate()
        isPaused = true
        self.playButton.setImage(UIImage(named: "playGreen"), for: .normal)
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapStopButton(_ sender: Any) {
        (self.timerTitle.text, self.timerLabel.text) = CGFloat(0).duration
        self.shapeLayer.strokeEnd = 0
        self.resetValues()
    }
    
    @IBAction func didTapPlayButton(_ sender: Any) {
        self.stopButton.isEnabled = true
        
        if isPaused {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
            isPaused = false
            self.playButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        else {
             self.stopTimer()
        }
    }
    
    func drawShapeLayer() {
        let center = CGPoint(x: self.timerImageView.bounds.width/2, y: self.timerImageView.bounds.height/2)
        let radius = (UIScreen.main.bounds.height == 480) ? 85 : ((self.timerImageView.bounds.width/300) * 120.0)
        let lineWidth: CGFloat = (UIScreen.main.bounds.width == 320) ? 7.0 : 15.0
        let startAngle: CGFloat = -CGFloat(Double.pi/2)
        let endAngle: CGFloat = -(CGFloat(Double.pi * 2) + CGFloat(Double.pi/2))
        
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        self.shapeLayer.strokeColor = color.cgColor
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.lineWidth = lineWidth
        self.shapeLayer.path = circlePath.cgPath
        self.shapeLayer.strokeEnd = 0
        self.timerImageView.layer.addSublayer(shapeLayer)
    }
    
    @objc func updateCounting() {
        self.seconds += 1
        let duration: CGFloat = CGFloat(self.session.time)
        
        guard self.seconds <= duration else {
            self.resetValues()
            return
        }
        
        self.shapeLayer.strokeEnd = (self.seconds)/duration
        (self.timerTitle.text, self.timerLabel.text) = self.seconds.duration
        self.playSound()
    }
    
    func playSound() {
        
        guard let stop = self.stops.first,
            self.seconds >= self.stopTime,
            let url = Bundle.main.url(forResource: stop.resource, withExtension: stop.type) else {
            return
        }
        
        self.stops.removeFirst()
        self.setSoundPlayTime()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            self.showAlertWithMessage("Error playing sound")
        }
    }
}
