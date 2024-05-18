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
    
    func extractHijriDate() -> String? {
        // Split the string by " - " to separate the date from the time
        let parts = self.components(separatedBy: " - ")

        // Ensure there are at least two parts after splitting
        guard parts.count > 1 else {
            print("Invalid input format")
            return nil
        }

        // Take the first part which contains the date
        let datePart = parts[0]

        // Split by "، " to isolate the date segment
        let dateComponents = datePart.components(separatedBy: "، ")

        // Ensure there are at least three components after splitting
        guard dateComponents.count > 2 else {
            print("Invalid date format")
            return nil
        }

        // Extract the actual date part (removing the weekday)
        let extractedDate = dateComponents[1] + " ، " + dateComponents[2]

        return extractedDate
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
    
    func hijriToGregorian(hijriDate: String) -> Date? {
        // Example of conversion logic, replace with actual library or API call
        // For demonstration, we assume the date "26 شوّال ، 1445" corresponds to "2024-05-25"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: "2024-05-25")
    }

    func daysUntil() -> Int? {
        // Extract the Hijri date part from the input string
        let parts = self.components(separatedBy: " - ")
        guard parts.count > 1 else {
            print("Invalid input format")
            return nil
        }
        
        let datePart = parts[0]
        let dateComponents = datePart.components(separatedBy: "، ")
        guard dateComponents.count > 2 else {
            print("Invalid date format")
            return nil
        }
        
        let hijriDate = dateComponents[1] + "، " + dateComponents[2]

        // Convert the Hijri date to Gregorian date
        guard let targetDate = hijriToGregorian(hijriDate: hijriDate) else {
            print("Failed to convert Hijri date to Gregorian date")
            return nil
        }
        
        // Calculate the number of days until the target date
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: currentDate, to: targetDate)
        return components.day
    }
    
//    func daysUntilDate() -> Int? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "ar_SA") // Set the locale to Arabic (Saudi Arabia)
//        dateFormatter.dateFormat = "EEEE ، dd MMMM ، yyyy - hh:mm:ss a"
//        
//        guard let targetDate = dateFormatter.date(from: self) else {
//            return nil // Return nil if the date string cannot be parsed
//        }
//        
//        // Get the current date
//        let currentDate = Date()
//        
//        // Calculate the time difference between the target date and the current date
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.day], from: currentDate, to: targetDate)
//        
//        if let days = components.day {
//            return days
//        } else {
//            return nil
//        }
//    }
    
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
