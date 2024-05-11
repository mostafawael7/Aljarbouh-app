//
//  ToastView.swift
//  Aljarbouh
//
//  Created by Hendawi on 02/05/2024.
//

import UIKit

class ToastView: UIView {
    private let textLabel = UILabel()
    
    init(message: String) {
        super.init(frame: .zero)
        configureUI()
        textLabel.text = message
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        addSubview(textLabel)
        
        // You can adjust the padding as needed
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func show(in view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1.0
        }) { (_) in
            UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseOut, animations: {
                self.alpha = 0.0
            }, completion: { (_) in
                self.removeFromSuperview()
            })
        }
    }
}
