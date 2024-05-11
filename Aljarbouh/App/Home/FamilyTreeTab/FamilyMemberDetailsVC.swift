//
//  FamilyMemberDetailsVC.swift
//  Aljarbouh
//
//  Created by Hendawi on 02/03/2024.
//

import UIKit
import Kingfisher

class FamilyMemberDetailsVC: UIViewController {

    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var profileImgView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var msgBtn: UIButton!
    @IBOutlet var infoViews: [UIView]!
    @IBOutlet var showMemberBtns: [UIButton]!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var birthdateLbl: UILabel!
    @IBOutlet weak var bornLocationLbl: UILabel!
    @IBOutlet weak var socialStatusLbl: UILabel!
    @IBOutlet weak var currentLocationLbl: UILabel!
    @IBOutlet weak var professionLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var specificAddressLbl: UILabel!
    
    var profile = Profile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
        setData()
        
    }
    
    private func initViews(){
        shareBtn.layer.cornerRadius = 20
        
        callBtn.layer.cornerRadius = 20
        callBtn.layer.borderWidth = 0.5
        callBtn.layer.borderColor = UIColor.primary.cgColor
        
        msgBtn.layer.cornerRadius = 20
        msgBtn.layer.borderWidth = 0.5
        msgBtn.layer.borderColor = UIColor.primary.cgColor
        
        profileImgView.layer.cornerRadius = 60
        profileImgView.layer.borderColor = UIColor.primary.cgColor
        profileImgView.layer.borderWidth = 0.5
        
        profileImg.layer.cornerRadius = 55
        
        numberView.layer.cornerRadius = 8
        
        for btn in showMemberBtns{
            btn.layer.cornerRadius = 20
            btn.layer.borderWidth = 0.5
            btn.layer.borderColor = UIColor.primary.cgColor
        }
        
        for view in infoViews{
            view.layer.cornerRadius = 15
            view.layer.borderColor = UIColor.lightGray.cgColor
            view.layer.borderWidth = 0.5
        }
    }
    
    private func setData(){
        if let media = profile.media?.first,
           let urlString = media.originalURL,
           let url = URL(string: urlString) {
            profileImg.kf.setImage(with: url, placeholder: UIImage(systemName: "person.crop.circle.fill"), options: [.transition(ImageTransition.fade(0.2))])
        } else {
            profileImg.image = UIImage(systemName: "person.crop.circle.fill")
        }
        
        numberLbl.text = String(profile.userID ?? 0)
        nameLbl.text = profile.getFullName()
        locationLbl.text = profile.bornLocation ?? "-"
        ageLbl.text = profile.dateOfBorn?.calculateAge() ?? "-"
        summaryLbl.text = profile.summary ?? "-"
        birthdateLbl.text = profile.dateOfBorn ?? "-"
        bornLocationLbl.text = profile.bornLocation ?? "-"
//        socialStatusLbl.text = profile.socialStatus
        currentLocationLbl.text = profile.bornLocation ?? "-"
        professionLbl.text = profile.profession ?? "-"
//        emailLbl.text = profile.email
//        mobileLbl.text = profile.mobile
//        specificAddressLbl.text = profile.specificAddress
        
    }
}
