//
//  MainActionsButton.swift
//  Aljarbouh
//
//  Created by Hendawi on 16/02/2024.
//

import UIKit

class MainActionsButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton(){
        layer.cornerRadius = frame.size.height / 2
    }
}
