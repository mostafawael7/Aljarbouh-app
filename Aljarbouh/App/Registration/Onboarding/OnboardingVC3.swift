//
//  OnboardingVC3.swift
//  Aljarbouh
//
//  Created by Hendawi on 17/02/2024.
//

import UIKit

class OnboardingVC3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtnClicked(_ sender: MainActionsButton) {
        navigateToVC(vc: "LoginVC")
    }
    
}
