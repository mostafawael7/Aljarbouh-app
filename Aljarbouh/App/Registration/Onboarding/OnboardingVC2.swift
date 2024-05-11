//
//  OnboardingVC2.swift
//  Aljarbouh
//
//  Created by Hendawi on 17/02/2024.
//

import UIKit

class OnboardingVC2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func nextBtnClicked(_ sender: MainActionsButton) {
        if let parentViewController = self.parent as? OnboardingVC {
            parentViewController.pageControl.currentPage = 2
            parentViewController.setViewControllers([parentViewController.pages[2]], direction: .forward, animated: true, completion: nil)
        }
    }
    
}
