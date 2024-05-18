//
//  MembersCollectionCell.swift
//  Aljarbouh
//
//  Created by Hendawi on 06/03/2024.
//

import UIKit
import Kingfisher

class MembersCollectionCell: UICollectionViewCell {

    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var jobLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        memberImage.layer.cornerRadius = 20
    }

    func configureCell(object: Attendee){
        print("object:\(object)")
        if let urlString = object.imageURL,
           let url = URL(string: urlString) {
            memberImage.kf.setImage(with: url, placeholder: UIImage(named: "member"), options: [.transition(ImageTransition.fade(0.2))])
        } else {
            memberImage.image = UIImage(named: "member")
        }
        
        nameLbl.text = object.name ?? "-"
        jobLbl.text = object.profession ?? "-"
    }
    
}
