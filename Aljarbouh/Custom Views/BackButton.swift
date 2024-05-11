//
//  BackButton.swift
//  Aljarbouh
//
//  Created by Hendawi on 16/02/2024.
//

import UIKit

class BackButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBtn()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBtn()
    }
    
    private func setupBtn(){
        let height = frame.height
        layer.cornerRadius = height / 2
        addTarget(self, action: #selector(backBtnClicked(_:)), for: .touchUpInside)
    }
    
    @objc private func backBtnClicked(_ sender: UIButton){
        self.findViewController()?.dismiss(animated: true, completion: nil)
    }
}

extension UIResponder {
    func findViewController() -> UIViewController? {
        if let viewController = self as? UIViewController {
            return viewController
        } else if let next = self.next {
            return next.findViewController()
        } else {
            return nil
        }
    }
}
