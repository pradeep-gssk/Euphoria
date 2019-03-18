//
//  EUHistoryShowViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 3/3/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import MessageUI

class EUHistoryShowViewController: UIViewController {
    
    var historyType: HistoryType!
    var history: History?
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.titleLabel.text = (self.history?.date as Date?)?.dateMonthString
        self.loadImage()
    }
    
    func loadImage() {
        guard let fileName = self.history?.fileName,
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let filePath = documentsDirectory.appendingPathComponent(fileName).path
        self.imageView.image = UIImage(contentsOfFile: filePath)
        
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapEmail(_ sender: Any) {
        self.sendEmail()
    }
    
    @IBAction func didTapTrash(_ sender: Any) {
        guard let history = self.history,
            let fileName = history.fileName,
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                return
        }
        
        let fileUrl = documentsDirectory.appendingPathComponent(fileName)
        do {
            try FileManager.default.removeItem(at: fileUrl)
            CoreDataHelper.shared.deleteHistory(history)
            self.navigationController?.popViewController(animated: true)
        }
        catch {
            self.showAlertWithMessage("Error deleting file")
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
        mail.setToRecipients([recipient])
        mail.setSubject(self.historyType.emailSubject)
        mail.setMessageBody(self.historyType.emailMessage, isHTML: true)
        self.present(mail, animated: true) {
        }
    }
}

extension EUHistoryPhotoViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            self.showAlertWithMessage("Error sending email")
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
