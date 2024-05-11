//
//  AddMemberVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 09/03/2024.
//

import UIKit

class AddMemberVC: UIViewController {

    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for tf in textFields {
            tf.layer.cornerRadius = 10
            tf.layer.borderColor = UIColor.lightGray.cgColor
            tf.layer.borderWidth = 1
        }
        
        nextBtn.layer.cornerRadius = 20
        
        cancelBtn.layer.cornerRadius = 20
        cancelBtn.layer.borderWidth = 1
        cancelBtn.layer.borderColor = UIColor.primary.cgColor
    }
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        self.findViewController()?.dismiss(animated: true, completion: nil)
    }
}
