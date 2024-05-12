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
    
    func extractDay() -> Int? {
        // Split the date string to extract the day part
        let components = self.components(separatedBy: "-")
        guard components.count == 2, let day = Int(components[0]) else {
            return nil // Return nil if the date string format is incorrect
        }
        return day
    }

    func extractMonth() -> String? {
        // Split the date string to extract the month part
        let components = self.components(separatedBy: "-")
        guard components.count == 2 else {
            return nil // Return nil if the date string format is incorrect
        }
        
        let monthName = components[1]
        // You can implement a mapping of month names in Arabic to their corresponding numeric values if needed
        // For this example, we'll simply return the month name as is
        return monthName
    }
    
    func daysUntilDate() -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ar_SA") // Set the locale to Arabic (Saudi Arabia)
        dateFormatter.dateFormat = "EEEE ، dd MMMM ، yyyy - hh:mm:ss a"
        
        guard let targetDate = dateFormatter.date(from: self) else {
            return nil // Return nil if the date string cannot be parsed
        }
        
        // Get the current date
        let currentDate = Date()
        
        // Calculate the time difference between the target date and the current date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: currentDate, to: targetDate)
        
        if let days = components.day {
            return days
        } else {
            return nil
        }
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
