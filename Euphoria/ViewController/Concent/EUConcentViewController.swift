//
//  EUConcentViewController.swift
//  Euphoria
//
//  Created by Krishna Pradeep on 6/17/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    @IBOutlet weak var policyView: UIView!
    @IBOutlet weak var iagreeButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
    
    private static var htmlViewType: HtmlViewType = .Concent
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.designViews()
        self.loadWebView()
        
        self.iagreeButton.rx.tap.subscribe({[weak self] state in
            guard let strongSelf = self else { return }
            UserDefaults.standard.set(true, forKey: I_AGREE)
            strongSelf.performSegue(withIdentifier: "ShowLoginView", sender: self)
        }).disposed(by: self.disposeBag)
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
            print("error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
