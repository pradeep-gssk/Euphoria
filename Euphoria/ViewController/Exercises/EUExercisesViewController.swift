//
//  EUExercisesViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/10/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUExercisesViewController: UIViewController {
    
    var exercises: [Exercises] = []
    var selectedExercise: String = ""
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1

        self.titleLabel.text = self.selectedExercise
        self.collectionView.collectionViewLayout = self.collectionViewFlowLayout
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUExerciseVideoViewController {
            viewController.exercise = sender as? Exercises
        }
    }
}

extension EUExercisesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.exercises.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciseVideos", for: indexPath) as! EUVideosListCell
        cell.name.text = self.exercises[indexPath.row].videoName
        if let image =  self.exercises[indexPath.row].thumbnail {
            cell.thumbnail.image = UIImage(named: image)
        }
        else {
            cell.thumbnail.image = nil
        }
        return cell
    }
}

extension EUExercisesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let exercise = self.exercises[indexPath.row]
        self.performSegue(withIdentifier: "ShowExercisesVideo", sender: exercise)
    }
}
