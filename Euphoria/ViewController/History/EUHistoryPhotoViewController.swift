//
//  EUHIstoryPhotoViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/13/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUHistoryPhotoViewController: UIViewController {

    var historyType: HistoryType!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonsStack: UIStackView!
    @IBOutlet weak var takePhotoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.titleLabel.text = historyType.title
        self.imageView.image = UIImage(named: historyType.placeholder)
        self.buttonsStack.isHidden = true
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? EUImagePickerViewController {
            viewController.delegate = self
            viewController.historyType = self.historyType
        }
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapPhotoButton(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.performSegue(withIdentifier: "ShowCameraPicker", sender: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func openPhotoLibrary() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = false
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func didTapTrash(_ sender: Any) {
        self.takePhotoButton.isHidden = false
        self.buttonsStack.isHidden = true
        self.imageView.image = UIImage(named: historyType.placeholder)
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        self.saveToDocuments()
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveToDocuments() {
        guard let image = self.imageView.image,
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
            let customerId = EUUser.user?.customerId else {
                //TODO: show failure alert
                return
        }
        
        let fileName = self.historyType.image + "-" + Date().dateString
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if let data = image.pngData() {
            do {
                try data.write(to: fileURL)
                CoreDataHelper.shared.saveHistory(NSDate(), name: fileName, imageType: self.historyType.image, customerId: Int64(customerId))
            } catch {
                self.showAlertWithMessage("Error saving file")
            }
        }
    }
}

extension EUHistoryPhotoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        self.imageView.image = info[.originalImage] as? UIImage
        self.takePhotoButton.isHidden = true
        self.buttonsStack.isHidden = false
    }
}

extension EUHistoryPhotoViewController: EUImagePickerViewDelegate {
    func imagePickerController(_ picker: EUImagePickerViewController, didFinishPickingImage image: UIImage) {
        self.imageView.image = image
        self.takePhotoButton.isHidden = true
        self.buttonsStack.isHidden = false
    }
}
