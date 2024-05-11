//
//  FilterButton.swift
//  Aljarbouh
//
//  Created by Hendawi on 01/03/2024.
//

import UIKit

class FilterButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        updateAppearance()
    }
    
    private func updateAppearance() {
        let height = self.frame.size.height
        layer.cornerRadius = height / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        if isSelected {
            backgroundColor = .primary
            setTitleColor(.buttonBackground, for: .normal)
            tintColor = .buttonBackground
        } else {
            backgroundColor = UIColor.buttonBackground
            setTitleColor(.primary, for: .selected)
            tintColor = .primary
        }
    }
}
