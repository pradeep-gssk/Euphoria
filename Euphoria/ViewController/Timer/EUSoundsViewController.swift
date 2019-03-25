//
//  EUSoundsViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/12/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import AVFoundation

class EUSoundsViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var soundsTableView: UITableView!

    var sounds: [Sound] = []
    var selectedIndexPath: IndexPath?
    var selectedSound: ((_ sound: Sound) -> Void)?
    var player: AVAudioPlayer?

    var checkMark: UIImage? {
        return UIImage(named: "checkMarkWhite")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.soundsTableView.tableFooterView = UIView()
        self.sounds = CoreDataHelper.shared.fetchSounds()
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.updateSound()
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateSound() {
        guard let indexPath = self.selectedIndexPath else {
//            self.showAlertWithMessage("Please select a sound")
            return
        }
        self.selectedSound?(self.sounds[indexPath.row])
    }
    
    func playSound(_ resource: String?, _ type: String?) {
        
        guard let url = Bundle.main.url(forResource: resource, withExtension: type) else { return }
                
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

extension EUSoundsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath) as! EUSoundTableViewCell
        let sound = self.sounds[indexPath.row]
        cell.title.text = sound.name
        
        cell.checkMark.image = (self.selectedIndexPath?.row == indexPath.row) ? self.checkMark : nil
        
        return cell
    }
}

extension EUSoundsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var indexPaths = [indexPath]
        if let currentSelectedIndexPath = self.selectedIndexPath {
            indexPaths.append(currentSelectedIndexPath)
        }
        let sound = self.sounds[indexPath.row]
        self.playSound(sound.resource, sound.type)
        self.selectedIndexPath = indexPath
        tableView.beginUpdates()
        tableView.reloadRows(at: indexPaths, with: .automatic)
        tableView.endUpdates()
    }
}

class EUSoundTableViewCell: UITableViewCell {
    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var title: UILabel!
}
