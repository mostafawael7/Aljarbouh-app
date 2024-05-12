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
    @IBOutlet weak var commonDetailsLbl: UILabel!
    @IBOutlet weak var commonDetailsTableView: UITableView!
    @IBOutlet weak var commonDetailsTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var familyDetailsLbl: UILabel!
    @IBOutlet weak var familyDetailsTableView: UITableView!
    @IBOutlet weak var familyDetailsTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    var profile = Profile()
    
    private let cellID = "FamilyMemberTableCell"
    private let rowHeight = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
//        initTableViews()
        
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
        
        for view in infoViews{
            view.layer.cornerRadius = 15
            view.layer.borderColor = UIColor.lightGray.cgColor
            view.layer.borderWidth = 0.5
        }
        
        commonDetailsLbl.isHidden = true
        commonDetailsTableView.isHidden = true

        familyDetailsLbl.isHidden = true
        familyDetailsTableView.isHidden = true
        
        scrollViewHeight.constant -= 192
        
//        if let family = profile.family {
//            if family.count > 0 {
//                print("family.count: \(family.count)")
//                familyDetailsLbl.isHidden = false
//                familyDetailsTableView.isHidden = false
//                
//                commonDetailsLbl.isHidden = false
//                commonDetailsTableView.isHidden = false
//                familyDetailsTableViewHeight.constant = CGFloat(family.count * rowHeight)
//                scrollViewHeight.constant += familyDetailsTableViewHeight.constant
//            }
//        }
    }
    
    private func initTableViews(){
        commonDetailsTableView.delegate = self
        commonDetailsTableView.dataSource = self
        commonDetailsTableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        commonDetailsTableView.rowHeight = CGFloat(rowHeight)
        
        familyDetailsTableView.delegate = self
        familyDetailsTableView.dataSource = self
        familyDetailsTableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        familyDetailsTableView.rowHeight = CGFloat(rowHeight)
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
        ageLbl.text = "\(profile.dateOfBorn?.calculateAge() ?? "-") عام"
//        summaryLbl.text = profile.summary ?? "-"
        if let summary = profile.summary {
            summaryLbl.text = summary
            adjustLayout()
        }else{
            summaryLbl.isHidden = true
        }
        birthdateLbl.text = profile.dateOfBorn ?? "-"
        bornLocationLbl.text = profile.bornLocation ?? "-"
        socialStatusLbl.text = profile.socialStatus ?? "-"
        currentLocationLbl.text = profile.residenceCountry ?? "-"
        professionLbl.text = profile.profission ?? "-"
        emailLbl.text = profile.email ?? "-"
        mobileLbl.text = profile.phone ?? "-"
        specificAddressLbl.text = profile.addressDetails ?? "-"
        
    }
    
    func adjustLayout() {
        // Calculate the required height for the label
        let labelSize = summaryLbl.sizeThatFits(CGSize(width: summaryLbl.frame.width, height: CGFloat.greatestFiniteMagnitude))
        
        // Update the label height constraint (assuming you are using Auto Layout)
        summaryLbl.heightAnchor.constraint(equalToConstant: labelSize.height).isActive = true
        
        print(labelSize)
        
        // Update the content size of the scroll view
        //            scrollView.contentSize = CGSize(width: scrollView.frame.width, height: labelSize.height + /* add height for image view, table view, and spacing */)
        scrollViewHeight.constant += labelSize.height
    }
}

extension FamilyMemberDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
//        case commonDetailsTableView:
//            return profile.family!.count
        case familyDetailsTableView:
            return profile.family!.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FamilyMemberTableCell
        switch tableView{
//            case commonDetailsTableView:
            case familyDetailsTableView:
            if let family = profile.family{
                cell.configureCell(object: family[indexPath.row])
            }
            default:
                break
        }
        return cell
    }
}
