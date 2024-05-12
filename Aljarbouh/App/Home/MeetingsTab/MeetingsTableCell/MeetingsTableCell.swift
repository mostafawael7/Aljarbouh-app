//
//  MeetingsTableCell.swift
//  Aljarbouh
//
//  Created by Hendawi on 06/03/2024.
//

import UIKit
import Kingfisher

class MeetingsTableCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dayNumLbl: UILabel!
    @IBOutlet weak var monthLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        eventImage.layer.cornerRadius = 10
        dateView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
    }
    
//    func extractDay(from dateString: String) -> String? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        
//        if let date = dateFormatter.date(from: dateString) {
//            let calendar = Calendar.current
//            let dayComponent = calendar.component(.day, from: date)
//            return "\(dayComponent)"
//        } else {
//            return nil // Return nil if the date string is invalid
//        }
//    }
//    
//    func extractArabicMonth(from dateString: String) -> String? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        
//        if let date = dateFormatter.date(from: dateString) {
//            let calendar = Calendar(identifier: .gregorian)
//            let monthComponent = calendar.component(.month, from: date)
//            
//            // Convert month number to Arabic month name
//            let arabicMonths = [
//                "يناير",
//                "فبراير",
//                "مارس",
//                "أبريل",
//                "مايو",
//                "يونيو",
//                "يوليو",
//                "أغسطس",
//                "سبتمبر",
//                "أكتوبر",
//                "نوفمبر",
//                "ديسمبر"
//            ]
//            
//            // Adjust monthComponent to match array index (1-based vs 0-based)
//            let arabicMonth = arabicMonths[monthComponent - 1]
//            return arabicMonth
//        } else {
//            return nil // Return nil if the date string is invalid
//        }
//    }
    
    func configureCell(object: Meeting){
        if let media = object.media?.first,
           let urlString = media.url,
           let url = URL(string: urlString) {
            eventImage.kf.setImage(with: url, placeholder: UIImage(named: "image1"), options: [.transition(ImageTransition.fade(0.2))])
        } else {
            eventImage.image = UIImage(named: "image1")
        }
        
        eventTitle.text = object.title ?? "-"
        eventLocation.text = object.address ?? "-"
        dayNumLbl.text = String(object.date?.extractDay() ?? 0)
        monthLbl.text = object.date?.extractMonth() ?? "-"
    }
    
}
