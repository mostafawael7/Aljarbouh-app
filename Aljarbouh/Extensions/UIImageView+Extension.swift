//
//  UIImageView+Extension.swift
//  Aljarbouh
//
//  Created by Hendawi on 26/04/2024.
//

import UIKit

extension UIImageView {
    
    func isRequired(){
        self.borderColor = .red
        self.borderWidth = 1
        self.cornerRadius = self.width / 2
    }
    
    func isValid(){
        self.borderWidth = 0
    }
    
    func addGradientOverlay() {
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        
        // Create a view to hold the gradient layer
        let gradientView = UIView(frame: self.bounds)
        gradientView.layer.addSublayer(gradientLayer)
        
        // Add the gradient view as an overlay to the image view
        self.addSubview(gradientView)
    }
}
