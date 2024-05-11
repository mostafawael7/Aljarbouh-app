//
//  UIString+Extension.swift
//  Aljarbouh
//
//  Created by Hendawi on 03/05/2024.
//

import Foundation

extension String {
    func extractDateInArabic() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Assuming UTC timezone
        
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        dateFormatter.locale = Locale(identifier: "ar")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd MMMM y")
        
        return dateFormatter.string(from: date)
    }
    
    func calculateAge() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let birthDate = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let currentDate = Date()
            if let ageComponents = calendar.dateComponents([.year], from: birthDate, to: currentDate).year{
                return String(ageComponents)
            }
        }
        print("Invalid date format")
        return nil
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
}
