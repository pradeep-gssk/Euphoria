//
//  EUVideosViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/12/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUVideosViewController: UIViewController {
    
    var videosObject: Videos?
    var videos: [Video] = []
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.videos = self.videosObject?.video?.allObjects as? [Video] ?? []
        
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.searchField.layer.borderColor = UIColor.singleColor(value: 151.0, alpha: 1).cgColor
        self.searchField.layer.borderWidth = 1
        self.searchField.setPaddingPointsOnLeft(14, andRight: 14)
        
        self.titleLabel.text = self.videosObject?.title
        self.collectionView.collectionViewLayout = self.collectionViewFlowLayout
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUVideoViewController {
            viewController.video = sender as? Video
        }
    }
}

extension EUVideosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! EUVideosListCell
        cell.name.text = self.videos[indexPath.row].videoName
        if let image =  self.videos[indexPath.row].thumbnail {
            cell.thumbnail.image = UIImage(named: image)
        }
        else {
            cell.thumbnail.image = nil
        }
        return cell
    }
}

extension EUVideosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = self.videos[indexPath.row]
        self.performSegue(withIdentifier: "ShowVideoView", sender: video)
    }
}
