//
//  SignupVC2.swift
//  Aljarbouh
//
//  Created by Hendawi on 17/02/2024.
//

import UIKit

class SignupVC2: UIViewController {
    private let viewModel = RegistrationViewModel()

    @IBOutlet weak var fatherNameTF: UITextField!
    @IBOutlet weak var grandfatherNameTF: UITextField!
    @IBOutlet weak var fatherGrandFatherTF: UITextField!
    @IBOutlet weak var birthdateTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var professionTF: UITextField!
    
    var profileImage = UIImage()
    var profileId = 0
    
    private let userImage = UIImage(systemName: "person.crop.circle")!
    private let birthdate = UIImage(systemName: "calendar")!
    
    private let datePicker = UIDatePicker()
    private var date: String?
    private let dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(profileId)
        
        initViews()
    }
    
    private func initViews(){
        fatherNameTF.addImage(image: userImage)
        grandfatherNameTF.addImage(image: userImage)
        fatherGrandFatherTF.addImage(image: userImage)
        birthdateTF.addImage(image: birthdate)
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        datePicker.locale = Locale(identifier: "ar")
        datePicker.tintColor = .primary
        datePicker.preferredDatePickerStyle = .inline
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        birthdateTF.inputView = datePicker
    }
    
    @objc private func datePickerValueChanged() {
        // Handle value change for the fromDatePicker
        let selectedDate = datePicker.date
        date = dateFormatter.string(from: selectedDate)
        birthdateTF.text = date
        birthdateTF.resignFirstResponder()
    }
    
    func isEmptyInput() -> Bool{
        var success = false
        if fatherNameTF.text == "" {
            fatherNameTF.isRequired()
            success = true
        }else{
            fatherNameTF.isValid()
        }
        if grandfatherNameTF.text == "" {
            grandfatherNameTF.isRequired()
            success = true
        }else{
            grandfatherNameTF.isValid()
        }
        if fatherGrandFatherTF.text == "" {
            fatherGrandFatherTF.isRequired()
            success = true
        }else{
            fatherGrandFatherTF.isValid()
        }
        if birthdateTF.text == "" {
            birthdateTF.isRequired()
            success = true
        }else{
            birthdateTF.isValid()
        }
        if locationTF.text == "" {
            locationTF.isRequired()
            success = true
        }else{
            locationTF.isValid()
        }
        if professionTF.text == "" {
            professionTF.isRequired()
            success = true
        }else{
            professionTF.isValid()
        }
        return success
    }
    
    private func tryUpdateProfile(){
        displayAnimatedActivityIndicatorView()
        viewModel.updateProfile(id: profileId, fatherName: fatherNameTF.text!, grandFatherName: grandfatherNameTF.text!, grand2FatherName: fatherGrandFatherTF.text!, bornLocation: locationTF.text!, image: profileImage, dateOfBirth: birthdateTF.text!, profession: professionTF.text!) { result in
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
//        let dest = self.storyboard!.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
//        dest.modalPresentationStyle = .fullScreen
//        dest.profile = viewModel.profile
//        self.present(dest, animated: true, completion: nil)
        navigateToVC(vc: "LoginVC", inStoryboard: "Main")
    }
    
    @IBAction func nextBtnClicked(_ sender: MainActionsButton) {
        print("nextBtnClicked")
        if isEmptyInput() {
            displayAlert(title: "خطأ", message: "ادخل جميع البيانات للاستمرار")
            return
        }
        
        tryUpdateProfile()
    }
}
