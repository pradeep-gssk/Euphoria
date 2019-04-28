//
//  EUConcentViewController.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/10/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import WebKit

class EUConcentViewController: UIViewController {

    static func loadConcentView() -> UIViewController {
        self.htmlViewType = .Concent
        return self.viewControllerForConcentView("ConcentNavViewController")
    }
    
    static func loadPrivacyView() -> UIViewController {
        self.htmlViewType = .Privacy
        return self.viewControllerForConcentView("ConcentViewController")
    }
    
    private static func viewControllerForConcentView(_ identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }

    @IBOutlet weak var policyView: UIView!
    @IBOutlet weak var iagreeButton: UIButton!
    @IBOutlet weak var webView: UIWebView!
    
    private static var htmlViewType: HtmlViewType = .Concent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.designViews()
        self.loadWebView()
    }
    
    func designViews() {
        self.policyView.layer.borderColor = UIColor.color(red: 140, green: 56, blue: 47, alpha: 1).cgColor
        self.policyView.layer.borderWidth = 2.0
        self.policyView.layer.cornerRadius = 8.0
        self.policyView.layer.shadowColor = UIColor.color(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        self.policyView.layer.shadowOpacity = 0.5
        self.policyView.layer.shadowOffset = CGSize(width: -1, height: 2)
        self.policyView.layer.shadowRadius = 4.0
        self.policyView.layer.shouldRasterize = true
        self.policyView.layer.rasterizationScale = UIScreen.main.scale
        
        self.iagreeButton.setTitle(EUConcentViewController.htmlViewType.title, for: .normal)
    }
    
    func loadWebView()  {
        guard let path = Bundle.main.path(forResource: EUConcentViewController.htmlViewType.description, ofType: "html") else { return }
        
        do {
            let htmlString = try String(contentsOfFile: path, encoding: .utf8)
            DispatchQueue.main.async {
                self.webView.loadHTMLString(htmlString, baseURL: nil)
            }
        }
        catch {
            self.showAlertWithMessage("Error loding webview")
        }
    }
    
    @IBAction func didTapIAgree(_ sender: Any) {
        switch EUConcentViewController.htmlViewType {
        case .Concent:
            UserDefaults.standard.set(true, forKey: I_AGREE)
            self.performSegue(withIdentifier: "ShowLoginView", sender: self)
        case .Privacy:
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension EUConcentViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        print(request)
        return true
    }
}
