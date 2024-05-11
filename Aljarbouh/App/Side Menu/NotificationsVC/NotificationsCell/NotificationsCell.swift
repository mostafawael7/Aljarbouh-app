//
//  NotificationsCell.swift
//  Aljarbouh
//
//  Created by Hendawi on 09/03/2024.
//

import UIKit
import Kingfisher

class NotificationsCell: UITableViewCell {

    @IBOutlet private weak var picView: UIImageView!
    @IBOutlet private weak var timeLbl: UILabel!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var countLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        picView.layer.cornerRadius = 10
        countView.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(notification: Notification) {
        if let url = URL(string: notification.imageURL ?? "") {
            picView.kf.setImage(with: url, placeholder: UIImage(systemName: "bell") ,options: [.transition(ImageTransition.fade(0.2))])
        }
        
        timeLbl.text = "\(notification.time ?? "-"), \(notification.date ?? "-")"
        titleLbl.text = notification.message ?? "-"
    }
    
}
