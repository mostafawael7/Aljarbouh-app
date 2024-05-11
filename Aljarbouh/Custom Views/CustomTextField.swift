//
//  CustomTextField.swift
//  Aljarbouh
//
//  Created by Hendawi on 11/05/2024.
//

import UIKit

class CustomTextField: UITextField {
    
    public var rightButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        borderStyle = .roundedRect
        borderWidth = 0.5
        borderColor = .lightGray
        cornerRadius = 10
    }
    
    public func setButton(image: UIImage){
        let buttonPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: frame.height))
        
        rightButton = UIButton(type: .custom)
        rightButton.setImage(image, for: .normal)
        rightButton.tintColor = .primary
        rightButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        
        rightButton.center = buttonPaddingView.center
        buttonPaddingView.addSubview(rightButton)
            
        leftView = buttonPaddingView
        leftViewMode = .always
        leftView?.tintColor = .lightGray
    }
    
    public func setIcon(icon: UIImage){
        let iconImageView = UIImageView(image: icon)
        iconImageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24) // Adjust size as needed
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .primary
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: frame.height))
        iconImageView.center = paddingView.center
        paddingView.addSubview(iconImageView)
        
        rightView = paddingView
        rightViewMode = .always
        rightView?.tintColor = .lightGray
    }
    
//    public func isPassword(){
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
//        button.setImage(UIImage(systemName: "eye.fill"), for: .selected)
//        
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
//        paddingView.addSubview(button)
//        
//        leftView = paddingView
//        leftViewMode = .always
//        leftView?.tintColor = .darkGray
//        
//        button.addTarget(self, action: #selector(showHidePassword(_:)), for: .touchUpInside)
//    }
    
//    @objc private func showHidePassword(_ sender: UIButton) {
//        sender.isSelected.toggle()
//        self.isSecureTextEntry.toggle()
//    }
}
