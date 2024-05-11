//
//  SignupVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 16/02/2024.
//

import UIKit

class SignupVC: UIViewController {
    let viewModel = RegistrationViewModel()
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    
    private var didUserSelectImage: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initImageView()
        initViews()
    }
    
    private func initViews(){
        passwordTF.addPasswordIcon()
        confirmPasswordTF.addPasswordIcon()
    }
    
    func isEmptyInput() -> Bool{
        var empty = false
        if firstNameTF.text == "" {
            firstNameTF.isRequired()
            empty = true
        }else{
            firstNameTF.isValid()
        }
        if emailTF.text == "" {
            emailTF.isRequired()
            empty = true
        }else{
            emailTF.isValid()
        }
        if passwordTF.text == "" {
            passwordTF.isRequired()
            empty = true
        }else{
            passwordTF.isValid()
        }
        if confirmPasswordTF.text == "" {
            confirmPasswordTF.isRequired()
            empty = true
        }else{
            confirmPasswordTF.isValid()
        }
        if mobileTF.text == "" {
            mobileTF.isRequired()
            empty = true
        }else{
            mobileTF.isValid()
        }
        if mobileTF.text == "" {
            mobileTF.isRequired()
            empty = true
        }else{
            mobileTF.isValid()
        }
        if !didUserSelectImage {
            profileImage.isRequired()
            empty = true
        }else{
            profileImage.isValid()
        }
        return empty
    }
    
    private func isSamePassword() -> Bool{
        return confirmPasswordTF.text == passwordTF.text ? true : false
    }
    
    private func tryRegister(){
        displayAnimatedActivityIndicatorView()
        viewModel.register(name: firstNameTF.text!, email: emailTF.text!, phone: mobileTF.text!, password: passwordTF.text!) { result in
            switch result{
            case .success:
                self.updateUI()
            case .failure(let error as NSError):
                self.handleInternetError(error: error)
                self.hideAnimatedActivityIndicatorView()
                self.displayDisappearingAlert(message: "حدث خطأ ما, الرجاء المحاولة مرة آخرى")
            }
        }
    }
    
    private func updateUI(){
        self.hideAnimatedActivityIndicatorView()
        let dest = self.storyboard!.instantiateViewController(withIdentifier: "SignupVC2") as! SignupVC2
        dest.modalPresentationStyle = .fullScreen
        dest.profileImage = profileImage.image!
        dest.profileId = (viewModel.loginResponse.profile?.id)!
        self.present(dest, animated: true, completion: nil)
    }
    
    @IBAction func nextBtnClicked(_ sender: MainActionsButton) {
        print("nextBtnClicked")
        if isEmptyInput() {
            displayAlert(title: "خطأ", message: "ادخل جميع البيانات للاستمرار")
            return
        }
        if !emailTF.text!.isValidEmail(){
            displayAlert(title: "خطأ", message: "يوجد خطأ في البريد الإلكتروني")
            return
        }
        if !isSamePassword(){
            displayAlert(title: "خطأ", message: "كلمة السر غير متطابقة")
            return
        }
        
        tryRegister()
    }
}

extension SignupVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func initImageView(){
        profileImage.layer.cornerRadius = 60
        profileImage.contentMode = .scaleAspectFill
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true
    }
    
    @objc func profileImageViewTapped() {
        showImagePicker()
    }
    
    func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "اختر صورة", message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "معرض الصور", style: .default) { _ in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        })
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(UIAlertAction(title: "التقط صورة", style: .default) { _ in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
        }
        alertController.addAction(UIAlertAction(title: "الغاء", style: .destructive, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image = selectedImage
            didUserSelectImage = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
