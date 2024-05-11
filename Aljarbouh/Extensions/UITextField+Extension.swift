//
//  UITextField+Extension.swift
//  Aljarbouh
//
//  Created by Hendawi on 24/02/2024.
//

import UIKit

extension UITextField {
    
    func isRequired(){
        self.borderColor = .red
        self.borderWidth = 1
        self.cornerRadius = 5
    }
    
    func isValid(){
        self.borderWidth = 0
    }
    
    func addImage(image: UIImage){
        let iconImageView = UIImageView(image: image)
        iconImageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24) // Adjust size as needed
        iconImageView.contentMode = .scaleAspectFit
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: frame.height))
        iconImageView.center = paddingView.center
        paddingView.addSubview(iconImageView)
        
        leftView = paddingView
        leftViewMode = .always
        leftView?.tintColor = .lightGray
    }
    
    func addSearchIcon(){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.image = UIImage(systemName: "magnifyingglass")
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        paddingView.addSubview(imageView)
        
        rightView = paddingView
        rightViewMode = .always
        rightView?.tintColor = .darkGray
    }
    
    func addPasswordIcon(){
        self.isSecureTextEntry = true
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        paddingView.addSubview(button)
        
        leftView = paddingView
        leftViewMode = .always
        leftView?.tintColor = .darkGray
        
        button.addTarget(self, action: #selector(showHidePassword(_:)), for: .touchUpInside)
    }
    
    @objc private func showHidePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isSecureTextEntry = !sender.isSelected
    }
    
}
