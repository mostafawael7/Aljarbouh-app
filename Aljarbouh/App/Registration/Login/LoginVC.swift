//
//  LoginVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 15/02/2024.
//

import UIKit

class LoginVC: UIViewController {
    let viewModel = LoginViewModel()

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginWithGoogleView: UIView!
    @IBOutlet weak var loginWithAppleView: UIView!
    @IBOutlet weak var signupBtn: UIButton!
    
    private let cornerRadius: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
    
    private func initViews(){
        
        passwordTF.addPasswordIcon()
        
        //loginWithGoogleView
        loginWithGoogleView.layer.borderColor = UIColor.darkGray.cgColor
        loginWithGoogleView.layer.borderWidth = 1
        loginWithGoogleView.layer.cornerRadius = cornerRadius
        let loginWithGoogle = UITapGestureRecognizer(target: self, action: #selector(loginWithGoogle(_:)))
        loginWithGoogleView.addGestureRecognizer(loginWithGoogle)
        
        //loginWithAppleView
        loginWithAppleView.layer.cornerRadius = cornerRadius
        let loginWithApple = UITapGestureRecognizer(target: self, action: #selector(loginWithApple(_:)))
        loginWithAppleView.addGestureRecognizer(loginWithApple)
        
        //signupBtn
        signupBtn.layer.borderWidth = 1
        signupBtn.layer.borderColor = UIColor.lightGray.cgColor
    }

    private func isValidInput() -> Bool{
        if emailTF.text == "" || passwordTF.text == "" {
            return false
        }
        return true
    }
    
    private func tryLogin(){
        displayAnimatedActivityIndicatorView()
        viewModel.login(email: emailTF.text!, password: passwordTF.text!) { result in
            switch result{
            case .success:
                self.updateUI()
            case .failure(let error as NSError):
                self.handleInternetError(error: error)
                self.hideAnimatedActivityIndicatorView()
                self.displayDisappearingAlert(message: "هناك خطأ في الايميل او كلمة السر")
            }
        }
    }
    
    private func updateUI(){
        self.hideAnimatedActivityIndicatorView()
        let dest = self.storyboard!.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
        dest.modalPresentationStyle = .fullScreen
        dest.profile = viewModel.loginResponse.profile
        self.present(dest, animated: true, completion: nil)
    }
    
    @objc private func loginWithGoogle(_ sender: UITapGestureRecognizer){
        print("loginWithGoogle")
    }
    
    @objc private func loginWithApple(_ sender: UITapGestureRecognizer){
        print("loginWithApple")
    }
    
    @IBAction func forgetPasswordBtnClicked(_ sender: UIButton) {
        print("forgetPasswordBtnClicked")
    }
    
    @IBAction func loginBtnClicked(_ sender: MainActionsButton) {
        print("loginBtnClicked")
        if isValidInput(){
            if emailTF.text!.isValidEmail() {
                tryLogin()
            }else{
                displayAlert(title: "خطأ", message: "البريد الإلكتروني غير صحيح")
            }
        } else{
            displayAlert(title: "خطأ", message: "ادخل جميع البيانات للاستمرار")
        }
    }
    
    @IBAction func signupBtnClicked(_ sender: MainActionsButton) {
        print("signupBtnClicked")
        navigateToVC(vc: "SignupVC")
    }
}

