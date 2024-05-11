//
//  OnboardingVC1.swift
//  Aljarbouh
//
//  Created by Hendawi on 17/02/2024.
//

import UIKit
import FluidTabBarController

class OnboardingVC1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextBtnClicked(_ sender: MainActionsButton) {
        if let parentViewController = self.parent as? OnboardingVC {
            parentViewController.pageControl.currentPage = 1
            parentViewController.setViewControllers([parentViewController.pages[1]], direction: .forward, animated: true, completion: nil)
        }
    }
}
