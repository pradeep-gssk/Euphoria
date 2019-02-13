//
//  ResponderTableViewCell.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/12/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit

class ResponderTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    
    var doneButtonTapped: (() -> Void)?
    
    var index: Int = 0
    
    let timePicker = GSTimeIntervalPicker(frame: .zero)
    let inputAccView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))

    override var inputView: UIView? {
        get {
            return self.timePicker
        }
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return self.inputAccView
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUp()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUp()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp() {
        self.timePicker.allowZeroTimeInterval = true
        self.timePicker.backgroundColor = UIColor.color(red: 150, green: 138, blue: 135, alpha: 1)
        self.inputAccView.backgroundColor = UIColor.color(red: 150, green: 138, blue: 135, alpha: 1)
        
        let imageView = UIImageView(image: UIImage(named: "cellBrownBg"))
        imageView.backgroundColor = UIColor.clear
        self.inputAccView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: inputAccView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: inputAccView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: inputAccView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: inputAccView.trailingAnchor)
            ])
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let doneButton = UIButton(type: .custom)
        doneButton.setTitle("Done", for: .normal)
        doneButton.frame = CGRect.zero
        doneButton.titleLabel?.font = UIFont(name: "GillSans-SemiBold", size: 17)
        doneButton.setTitleColor(UIColor.white, for: .normal)
        doneButton.addTarget(self, action: #selector(ResponderTableViewCell.didTapDoneButton), for: .touchUpInside)
        self.inputAccView.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: inputAccView.topAnchor, constant: 5),
            doneButton.bottomAnchor.constraint(equalTo: inputAccView.bottomAnchor, constant: -5),
            doneButton.trailingAnchor.constraint(equalTo: inputAccView.trailingAnchor, constant: -16),
            doneButton.widthAnchor.constraint(equalToConstant: 50)
            ])
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc func didTapDoneButton() {
        self.doneButtonTapped?()
    }
    
    //MARK: UIResponder
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        let status = super.becomeFirstResponder()
        return status
    }
    
    override func resignFirstResponder() -> Bool {
        let success = super.resignFirstResponder()
        return success
    }
}
