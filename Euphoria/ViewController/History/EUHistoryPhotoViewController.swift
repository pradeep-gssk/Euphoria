//
//  EUHIstoryPhotoViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/13/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import MessageUI

class EUHistoryPhotoViewController: UIViewController {

    var historyType: HistoryType!
    var history: EUHistory!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var takePhotoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = history.title
        self.imageView.image = UIImage(named: historyType.placeholder)
        self.buttonStackView.isHidden = true
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapPhotoButton(_ sender: Any) {
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
        vc.allowsEditing = true
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        self.takePhotoButton.isHidden = false
        self.buttonStackView.isHidden = true
        self.imageView.image = UIImage(named: historyType.placeholder)
    }
    
    @IBAction func didTapSend(_ sender: Any) {
        self.saveToDocuments()
        self.sendEmail()
    }
    
    func saveToDocuments() {
        guard let image = self.imageView.image,
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                //TODO: show failure alert
                return
        }
        
        let fileName = self.historyType.image
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if let data = image.pngData() {
            do {
                try data.write(to: fileURL)
            } catch {
                //TODO: Show error
                print("error saving file:", error)
            }
        }
    }
    
    func sendEmail() {
        guard MFMailComposeViewController.canSendMail(),
            let image = self.imageView.image,
            let data = image.pngData() else {
            //TODO: show failure alert
            return
        }
        
        let mail = MFMailComposeViewController()
        mail.addAttachmentData(data, mimeType: "image/png", fileName: self.historyType.image)
        mail.setToRecipients(["eenadu18@gmail.com"])
        mail.setSubject(self.historyType.emailSubject)
        mail.setMessageBody(self.historyType.emailMessage, isHTML: true)
        self.present(mail, animated: true) {
            
        }
    }
}

extension EUHistoryPhotoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        self.imageView.image = info[.editedImage] as? UIImage
        self.takePhotoButton.isHidden = true
        self.buttonStackView.isHidden = false
    }
}

extension EUHistoryPhotoViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let error = error {
            //TODO: Show error
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
}
