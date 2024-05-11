//
//  HSNetworkAlertVC.swift
//  Tawasol ERP
//
//  Created by tawasol alriyadh on 25/12/2023.
//

import UIKit

class HSNetworkAlertVC: UIViewController {
    
    @IBOutlet weak var nointernetLabel: UILabel!
    @IBOutlet weak var noInternetDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nointernetLabel.text = "لا يوجد اتصال بالانترنت"
        noInternetDescriptionLabel.text = "تأكد من الاتصال بالانترنت وحاول مرة أخرى"
    }
    
    @IBAction func alertEvent(_ sender:UIButton){
        
        if Helper.sharedHelper.isConnectedToNetwork() {
            self.dismiss(animated: true)
        }else{
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: (view?.center.x)! - 10, y: (view?.center.y)!))
            animation.toValue = NSValue(cgPoint: CGPoint(x: (view?.center.x)! + 10, y: (view?.center.y)!))
            view?.layer.add(animation, forKey: "position")
        }
    }
}
