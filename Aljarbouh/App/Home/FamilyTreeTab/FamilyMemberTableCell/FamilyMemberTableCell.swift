//
//  FamilyMemberTableCell.swift
//  Aljarbouh
//
//  Created by Hendawi on 11/05/2024.
//

import UIKit
import Kingfisher

class FamilyMemberTableCell: UITableViewCell {

    @IBOutlet weak private var imgView: UIImageView!
    @IBOutlet weak private var goToProfileBtn: UIButton!
    @IBOutlet weak private var relationLbl: UILabel!
    @IBOutlet weak private var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        goToProfileBtn.layer.cornerRadius = 20
        goToProfileBtn.layer.borderWidth = 0.5
        goToProfileBtn.layer.borderColor = UIColor.primary.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(object: Family){
        if let urlString = object.imageURL, let url = URL(string: urlString) {
            imgView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.crop.circle.fill"), options: [.transition(ImageTransition.fade(0.2))])
        } else {
            imgView.image = UIImage(systemName: "person.crop.circle.fill")
        }
        
        nameLbl.text = object.firstName ?? "-"
        relationLbl.text = object.relationType ?? "-"
    }
    
    @IBAction func goToProfileBtnClicked(_ sender: UIButton) {
    }
}
