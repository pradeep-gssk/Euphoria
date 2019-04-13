//
//  EUAccountViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 7/8/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUAccountViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    
    var titles = [String]()
    var values = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = EUUser.user {
            titles = ["First name:", "Last Name:", "Phone:", "E-mail:"]
            values.append(user.firstName.stringValue)
            values.append(user.lastName.stringValue)
            values.append(user.phone.stringValue)
            values.append(user.email.stringValue)
        }
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.bottomView.layer.borderColor = UIColor.singleColor(value: 151.0, alpha: 1).cgColor
        self.bottomView.layer.borderWidth = 1
        self.userImageView.layer.cornerRadius = 77.5
        self.userImageView.layer.masksToBounds = true
        self.userImageView.loadUserImage()
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSignOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: USER_PROFILE_DATA)
        UserDefaults.standard.synchronize()
        appDelegate.showLoginView()
    }
    
    @IBAction func didTapUserImage(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openImagePickerForSource(.camera)
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openImagePickerForSource(.photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func openImagePickerForSource(_ sourceType: UIImagePickerController.SourceType) {
        let vc = UIImagePickerController()
        vc.sourceType = sourceType
        if sourceType == .camera {
            vc.cameraCaptureMode = UIImagePickerController.CameraCaptureMode.photo
            vc.cameraDevice = UIImagePickerController.CameraDevice.front
        }
        vc.allowsEditing = true
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    func saveToDocuments() {
        guard let image = self.userImageView.image,
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
            let customerId = EUUser.user?.customerId else {
                //TODO: show failure alert
                return
        }
        
        let fileURL = documentsDirectory.appendingPathComponent("\(customerId)")
        if let data = image.pngData() {
            do {
                try data.write(to: fileURL)
            } catch {
                self.showAlertWithMessage("Error saving file")
            }
        }
    }
}

extension EUAccountViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as! EUAccountViewCell
        cell.titleLabel.text = self.titles[indexPath.row]
        cell.detailLabel.text = self.values[indexPath.row]
        return cell
    }
}

extension EUAccountViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        self.userImageView.image = info[.editedImage] as? UIImage
        self.saveToDocuments()
    }
}

class EUAccountViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
}
