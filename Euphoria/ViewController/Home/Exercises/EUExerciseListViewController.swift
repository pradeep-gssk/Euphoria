//
//  EUExerciseListViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/7/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EUExerciseListViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var exerciseCollectionView: UICollectionView!
    
    var exercise: EUExercise = EUExercise()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.layer.borderColor = UIColor(red: (197.0/255.0), green: (196.0/255.0), blue: (192.0/255.0), alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.searchField.layer.borderColor = UIColor(red: (151.0/255.0), green: (151.0/255.0), blue: (151.0/255.0), alpha: 1).cgColor
        self.searchField.layer.borderWidth = 1
        self.titleLabel.text = self.exercise.detail
        self.searchField.setPaddingPointsOnLeft(14, andRight: 14)
        
        let flowLayout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width-100)/3
        flowLayout.itemSize = CGSize(width: width, height: width + 35)
        flowLayout.minimumLineSpacing = 25
        flowLayout.sectionInset = UIEdgeInsetsMake(25, 25, 25, 25)
        self.exerciseCollectionView.collectionViewLayout = flowLayout
        
        self.homeButton.rx.tap.subscribe({[weak self] state in
            self?.performSegue(withIdentifier: "GoToHome", sender: self)
        }).disposed(by: self.disposeBag)
        
        self.backButton.rx.tap.subscribe({[weak self] state in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: self.disposeBag)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUExerciseViewController, let exercise = sender as? EUExercise {
            viewController.exercise = exercise
        }
    }
}

extension EUExerciseListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciseCollectionViewCell", for: indexPath) as! EUExerciseCollectionViewCell
        cell.exerciseImage.image = UIImage(named: "photo")
        cell.playImage.image = UIImage(named: "play")
        cell.exerciseName.text = "Exercise"
        return cell
    }
}

extension EUExerciseListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowExerciseView", sender: self.exercise)
    }
}

class EUExerciseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var exerciseName: UILabel!
}
