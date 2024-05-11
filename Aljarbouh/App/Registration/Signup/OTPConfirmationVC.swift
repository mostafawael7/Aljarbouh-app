//
//  OTPConfirmationVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 16/02/2024.
//

import UIKit

class OTPConfirmationVC: UIViewController {
    
    @IBOutlet weak var TF1: UITextField!
    @IBOutlet weak var TF2: UITextField!
    @IBOutlet weak var TF3: UITextField!
    @IBOutlet weak var TF4: UITextField!
    @IBOutlet weak var TF5: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTextFields()
    }
    
    @IBAction func resendCodeBtnClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func confirmBtnCliced(_ sender: MainActionsButton) {
        navigateToVC(vc: "SignupVC2")
    }
}

extension OTPConfirmationVC: UITextFieldDelegate {
    
    private func initTextFields(){
        //---------------------------------------------------------------------------------------
        // Add a delegate of each UITextField.
        //---------------------------------------------------------------------------------------
        self.TF1.delegate = self
        self.TF2.delegate = self
        self.TF3.delegate = self
        self.TF4.delegate = self
        self.TF5.delegate = self
        //---------------------------------------------------------------------------------------
        // For each UITextField add target action for ( editingChanged )
        //---------------------------------------------------------------------------------------
        TF1.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        TF2.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        TF3.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        TF4.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        TF5.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        //---------------------------------------------------------------------------------------
        // Add line as TF1.becomeFirstResponder() to open keyboard for first field
        //---------------------------------------------------------------------------------------
        TF1.becomeFirstResponder()
        //---------------------------------------------------------------------------------------
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        //-----------------------------------------------------------------------------------
        // when text lenght equal to 1
        //-----------------------------------------------------------------------------------
        if  text?.count == 1 {
            switch textField{
            case TF1:
                TF2.becomeFirstResponder()
            case TF2:
                TF3.becomeFirstResponder()
            case TF3:
                TF4.becomeFirstResponder()
            case TF4:
                TF5.becomeFirstResponder()
            case TF5:
                TF5.resignFirstResponder()
                self.dismissKeyboard()
            default:
                break
            }
        }
        //-----------------------------------------------------------------------------------
        // when text lenght equal to 0
        //-----------------------------------------------------------------------------------
//        if  text?.count == 0 {
//            switch textField{
//            case TF1:
//                TF1.becomeFirstResponder()
//            case TF2:
//                TF1.becomeFirstResponder()
//            case TF3:
//                TF2.becomeFirstResponder()
//            case TF4:
//                TF3.becomeFirstResponder()
//            case TF5:
//                TF4.becomeFirstResponder()
//            default:
//                break
//            }
//        }
    }
    //-----------------------------------------------------------------------------------
    // For Close Keybored
    //-----------------------------------------------------------------------------------
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = .white
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = .placeholder
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.count ?? 0) + string.count - range.length
        return newLength <= 1
    }
}
