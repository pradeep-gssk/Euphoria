//
//  EUActivityViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 3/25/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class EUActivityViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var treatment: UILabel!
    @IBOutlet weak var therapist: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var discountPercent: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var room: UILabel!
    @IBOutlet weak var roomNumber: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    
    var activity: EUActivity!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.layer.borderColor = UIColor.color(red: 197.0, green: 196.0, blue: 192.0, alpha: 1).cgColor
        self.headerView.layer.borderWidth = 1
        self.treatment.text = activity.trtDescription
        self.therapist.text = activity.appointmentTherapist
        self.price.text = NSDecimalNumber(decimal: activity.trtPrice ?? 0).stringValue
        self.discountPercent.text = NSDecimalNumber(decimal: activity.discountPrcnt ?? 0).stringValue + "%"
        self.discount.text = NSDecimalNumber(decimal: activity.discountValue ?? 0).stringValue
        self.date.text = activity.appointmentDate
        self.duration.text = "\(activity.trtDuration ?? 0)"
        self.startTime.text = activity.appointmentStartTime
        self.endTime.text = activity.appointmentEndTime
        self.room.text = activity.appointmentRoom
        self.roomNumber.text = activity.pmsRoom
        self.productDescription.text = activity.prodDescr
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
