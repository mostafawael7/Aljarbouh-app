//
//  FamilyTreeTableCell.swift
//  Aljarbouh
//
//  Created by Hendawi on 02/03/2024.
//

import UIKit
import Kingfisher

class FamilyTreeTableCell: UITableViewCell {

    @IBOutlet weak var imageParentView: UIView!
    @IBOutlet weak var imageMainView: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var deadImage: UIImageView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationViewWidth: NSLayoutConstraint!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var ageLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        deadImage.isHidden = true
        starImage.isHidden = true
        
        imageParentView.layer.cornerRadius = 45
        imageParentView.layer.borderColor = UIColor.lightGray.cgColor
        imageParentView.layer.borderWidth = 0.5
        imageMainView.layer.cornerRadius = 35
        numberView.layer.cornerRadius = 10
        locationView.layer.cornerRadius = 15
        locationView.layer.borderColor = UIColor.lightGray.cgColor
        locationView.layer.borderWidth = 0.5
        ageView.layer.cornerRadius = 15
        ageView.layer.borderColor = UIColor.lightGray.cgColor
        ageView.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        deadImage.isHidden = true
        starImage.isHidden = true
    }
    
    func isStar(){
        starImage.isHidden = false
    }
    
    func isDead(){
        deadImage.isHidden = false
    }
    
    func configureCell(profile: Profile){
        if let media = profile.media?.first,
           let urlString = media.originalURL,
           let url = URL(string: urlString) {
            imageMainView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.crop.circle.fill"), options: [.transition(ImageTransition.fade(0.2))])
        } else {
            imageMainView.image = UIImage(systemName: "person.crop.circle.fill")
        }
        
        nameLbl.text = profile.getFullName()
        locationLbl.text = profile.bornLocation ?? "-"
        
        ageLbl.text = "\(profile.dateOfBorn?.calculateAge() ?? "-") عام"
        numberLbl.text = String(profile.userID ?? 0)
        
        if profile.status == "نشط" {
            isStar()
        }
        
        if profile.live == 0{
            isDead()
        }
        
//        adjustLayout(str: locationLbl)
    }
    
//    func adjustLayout(str: UILabel) {
//        // Calculate the required size for the label
//        let labelSize = str.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: str.frame.height))
//        
//        // Update the label width constraint (assuming you are using Auto Layout)
//        str.widthAnchor.constraint(equalToConstant: labelSize.width).isActive = true
//        
//        // Update the width constraint of the view (assuming viewWidth is the constraint controlling the overall width of your view)
//        locationViewWidth.constant = 48 + labelSize.width
//    }

}
