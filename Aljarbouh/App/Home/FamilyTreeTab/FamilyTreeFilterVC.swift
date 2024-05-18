//
//  FamilyTreeFilterVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 06/03/2024.
//

import UIKit
import DropDown

class FamilyTreeFilterVC: UIViewController {

    @IBOutlet weak var networkBtn: FilterButton!
    @IBOutlet weak var listBtn: FilterButton!
    @IBOutlet weak var ageTF: CustomTextField!
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var birthdayYearTF: CustomTextField!
    @IBOutlet weak var generationTF: CustomTextField!
    @IBOutlet weak var generationView: UIView!
    @IBOutlet weak var jobTF: CustomTextField!
    @IBOutlet weak var locationTF: CustomTextField!
    @IBOutlet weak var socialStatusTF: CustomTextField!
    @IBOutlet weak var applyFilterBtn: UIButton!
    @IBOutlet weak var cancelFilterBtn: UIButton!
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    let cancelFilterBtnColor: UIColor = .darkGray
    
    private let datePicker = UIDatePicker()
    private var date: String?
    private let dateFormatter = DateFormatter()
    
    private let socialStatusDropdown = DropDown()
    private let socialStatuses = ["أعزب", "متزوج"]
    
    var completion: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initDropdown()
        initDatePicker()
    }
    
    private func initViews(){
        ageTF.layer.cornerRadius = 10
        ageTF.layer.borderColor = UIColor.lightGray.cgColor
        ageTF.layer.borderWidth = 1
        
        birthdayYearTF.layer.cornerRadius = 10
        birthdayYearTF.layer.borderColor = UIColor.lightGray.cgColor
        birthdayYearTF.layer.borderWidth = 1
        
        generationTF.layer.cornerRadius = 10
        generationTF.layer.borderColor = UIColor.lightGray.cgColor
        generationTF.layer.borderWidth = 1
        
        jobTF.layer.cornerRadius = 10
        jobTF.layer.borderColor = UIColor.lightGray.cgColor
        jobTF.layer.borderWidth = 1
        
        locationTF.layer.cornerRadius = 10
        locationTF.layer.borderColor = UIColor.lightGray.cgColor
        locationTF.layer.borderWidth = 1
        
        socialStatusTF.layer.cornerRadius = 10
        socialStatusTF.layer.borderColor = UIColor.lightGray.cgColor
        socialStatusTF.layer.borderWidth = 1
        socialStatusTF.setButton(image: UIImage(systemName: "chevron.down")!)
        socialStatusTF.rightButton.addTarget(self, action: #selector(openDropDown), for: .touchUpInside)
        
        applyFilterBtn.layer.cornerRadius = 25
        cancelFilterBtn.tintColor = cancelFilterBtnColor
        cancelFilterBtn.layer.cornerRadius = 25
        cancelFilterBtn.layer.borderWidth = 1
        cancelFilterBtn.layer.borderColor = cancelFilterBtnColor.cgColor
    }
    
    private func initDropdown(){
        socialStatusTF.delegate = self
        socialStatusDropdown.anchorView = socialStatusTF
        socialStatusDropdown.dataSource = socialStatuses
        socialStatusDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.socialStatusTF.text = item
            socialStatusDropdown.hide()
        }
    }
    
    private func initDatePicker(){
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        datePicker.locale = Locale(identifier: "ar")
        datePicker.tintColor = .primary
        datePicker.preferredDatePickerStyle = .inline
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        birthdayYearTF.inputView = datePicker
    }
    
    @objc private func datePickerValueChanged() {
        // Handle value change for the fromDatePicker
        let selectedDate = datePicker.date
        date = dateFormatter.string(from: selectedDate)
        birthdayYearTF.text = date
//        birthdayYearTF.resignFirstResponder()
    }
    
    @objc private func openDropDown() {
        socialStatusDropdown.show()
//        socialStatusTF.resignFirstResponder()
    }
    
    private func toggleTextFields(value: Bool){
        ageView.isHidden = value
        generationView.isHidden = value
    }
    
    @IBAction func filterBtnClicked(_ sender: FilterButton) {
        if sender == networkBtn && !networkBtn.isSelected {
            networkBtn.isSelected = true
            listBtn.isSelected = false
            toggleTextFields(value: false)
        } else if sender == listBtn && !listBtn.isSelected {
            networkBtn.isSelected = false
            listBtn.isSelected = true
            toggleTextFields(value: true)
        }
    }
    @IBAction func applyFilterBtnClicked(_ sender: UIButton) {
        var filters = "?"
        if birthdayYearTF.text != "" {
            filters+="date_of_born=\(birthdayYearTF.text!)"
        }
        if jobTF.text != "" {
            filters+="&profission=\(jobTF.text!)"
        }
        if locationTF.text != "" {
            filters+="&residence_country=\(locationTF.text!)"
        }
        if socialStatusTF.text != ""{
            filters+="&social_status=\(socialStatusTF.text!)"
        }
        completion?(filters)
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelFilterBtnClicked(_ sender: UIButton) {
        ageTF.text?.removeAll()
        birthdayYearTF.text?.removeAll()
        generationTF.text?.removeAll()
        jobTF.text?.removeAll()
        locationTF.text?.removeAll()
        socialStatusTF.text?.removeAll()
    }
    
}


extension FamilyTreeFilterVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case socialStatusTF:
            socialStatusDropdown.show()
//            socialStatusTF.resignFirstResponder()
        default:
            break
        }
    }
}
