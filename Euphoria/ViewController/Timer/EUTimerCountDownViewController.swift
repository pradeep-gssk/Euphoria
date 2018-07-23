//
//  EUTimerCountDownViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/22/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUTimerCountDownViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var timerImageView: UIImageView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    var session = EUSession()
    
    let color = UIColor(red: (140.0/255.0), green: (56.0/255.0), blue: (47.0/255.0), alpha: 1.0)
    let shapeLayer = CAShapeLayer()
    var timer = Timer()
    var seconds: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.layer.borderColor = UIColor(red: (197.0/255.0), green: (196.0/255.0), blue: (192.0/255.0), alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        
        self.homeButton.rx.tap.subscribe({[weak self] state in
            self?.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
        
        self.backButton.rx.tap.subscribe({[weak self] state in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: self.disposeBag)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.drawShapeLayer()
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
        
       self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
        self.seconds += 1
        let duration: CGFloat = CGFloat(self.session.countDownDuration)
        
        guard self.seconds <= duration else {
            self.timer.invalidate()
            return
        }
        
        self.shapeLayer.strokeEnd = (self.seconds)/duration
        self.timerLabel.text = self.seconds.duration
    }
}
