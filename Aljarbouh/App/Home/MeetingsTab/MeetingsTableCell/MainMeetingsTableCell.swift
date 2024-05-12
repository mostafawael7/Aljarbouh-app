//
//  MainMeetingsTableCell.swift
//  Aljarbouh
//
//  Created by Hendawi on 12/05/2024.
//

import UIKit
import Kingfisher

class MainMeetingsTableCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var countdownLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundImg.addGradientOverlay()
        backgroundImg.layer.cornerRadius = 20
        
        dateView.layer.cornerRadius = 25
        dateView.layer.borderWidth = 1
        dateView.layer.borderColor = UIColor.white.cgColor
        
        addressView.layer.cornerRadius = 15
        addressView.layer.borderWidth = 1
        addressView.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(object: Meeting){
        if let media = object.media?.first,
           let urlString = media.url,
           let url = URL(string: urlString) {
            backgroundImg.kf.setImage(with: url, placeholder: UIImage(named: "image1"), options: [.transition(ImageTransition.fade(0.2))])
        } else {
            backgroundImg.image = UIImage(named: "image1")
        }
        
        dayLbl.text = String(object.date?.extractDay() ?? 0)
        monthLbl.text = object.date?.extractMonth() ?? "-"
        dateLbl.text = object.hijriDate ?? "-"
        countdownLbl.text = "\(object.hijriDate?.daysUntilDate() ?? 0)الوقت المتبقي: "
        titleLbl.text = object.title
        addressLbl.text = object.address
    }
    
}
