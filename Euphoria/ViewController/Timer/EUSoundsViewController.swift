//
//  EUSoundsViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/12/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUSoundsViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var soundsTableView: UITableView!

    var sounds: [Sound] = []
    var selectedIndexPath: IndexPath?
    var selectedSound: ((_ sound: Sound) -> Void)?
    
    var checkMark: UIImage? {
        return UIImage(named: "checkMarkWhite")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.soundsTableView.tableFooterView = UIView()
        self.sounds = CoreData.sharedInstance.fetchSounds()
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.updateSound()
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateSound() {
        guard let indexPath = self.selectedIndexPath else {
            //TODO: show error
            return
        }
        self.selectedSound?(self.sounds[indexPath.row])
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
