//
//  ProfileVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 09/03/2024.
//

import UIKit
import Kingfisher

class ProfileVC: UIViewController {
    private var viewModel = ProfileViewModel()

    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var profileImgView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var editDataBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet var infoViews: [UIView]!
    @IBOutlet var showMemberBtns: [UIButton]!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var birthdateLbl: UILabel!
    @IBOutlet weak var bornLocationLbl: UILabel!
    @IBOutlet weak var socialStatusLbl: UILabel!
    @IBOutlet weak var currentAddressLbl: UILabel!
    @IBOutlet weak var professionLbl: UILabel!
    @IBOutlet weak var fatherNameLbl: UILabel!
    @IBOutlet weak var motherNameLbl: UILabel!
    @IBOutlet weak var wifeNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var specificAddressLbl: UILabel!
    
    private var profile = Profile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
        getData()
    }
    
    private func initViews(){
        shareBtn.layer.cornerRadius = 20
        
        profileImgView.layer.cornerRadius = 60
        profileImgView.layer.borderColor = UIColor.primary.cgColor
        profileImgView.layer.borderWidth = 0.5
        
        editDataBtn.layer.cornerRadius = 15
        editDataBtn.layer.borderWidth = 0.5
        editDataBtn.layer.borderColor = UIColor.darkGray.cgColor
        
        profileImg.layer.cornerRadius = 55
        
        numberView.layer.cornerRadius = 8
        
        for btn in showMemberBtns{
            btn.layer.cornerRadius = 16
            btn.layer.borderWidth = 0.5
            btn.layer.borderColor = UIColor.primary.cgColor
        }
        
        for view in infoViews{
            view.layer.cornerRadius = 15
            view.layer.borderColor = UIColor.lightGray.cgColor
            view.layer.borderWidth = 0.5
        }
    }
    
    func getData(){
        displayAnimatedActivityIndicatorView()
        let id = UserDefaultsManager.shared.retrieve(forKey: UserDefaultKeys.ProfileID) as! Int
        viewModel.retrieve(id: id){ [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success:
                self.profile = viewModel.profile
                self.updateUI()
            case .failure(let error as NSError):
                self.hideAnimatedActivityIndicatorView()
                self.handleInternetError(error: error)
            }
        }
    }
    
    func updateUI(){
        if let url = URL(string: profile.media![0].originalURL ?? "") {
            profileImg.kf.setImage(with: url, placeholder: UIImage(systemName: "person.crop.circle.fill") ,options: [.transition(ImageTransition.fade(0.2))])
        }
        nameLbl.text = profile.getFullName()
        numberLbl.text = String(profile.userID ?? 0)
        locationLbl.text = profile.bornLocation ?? "-"
        summaryLbl.text = profile.summary ?? "-"
        birthdateLbl.text = profile.dateOfBorn ?? "-"
        bornLocationLbl.text = profile.bornLocation ?? "-"
        professionLbl.text = profile.profission ?? "-"
        hideAnimatedActivityIndicatorView()
    }
    
    @IBAction func addMemberBtnClicked(_ sender: UIButton) {
        navigateToVC(vc: "AddMemberVC", inStoryboard: "SideMenu")
    }
}
