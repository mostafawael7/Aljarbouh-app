//
//  Dictionary.swift
//  Tawasol ERP
//
//  Created by tawasol alriyadh on 20/12/2023.
//

import Foundation

extension Dictionary {
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            if #available(iOS 13.0, *) {
                let jsonData = try JSONSerialization.data(withJSONObject: self, options:[ .prettyPrinted ,.sortedKeys ,.withoutEscapingSlashes] )
                return String(bytes: jsonData, encoding: .utf8) ?? invalidJson
            } else {
                // Fallback on earlier versions
                let jsonData = try JSONSerialization.data(withJSONObject: self, options:[ .prettyPrinted ,.sortedKeys ] )
                return String(bytes: jsonData, encoding: .utf8) ?? invalidJson
            }
            
        } catch {
            return invalidJson
        }
    }
    
    func printJson() {
        print("DEBUG: Parameters --> \(json)")
    }
}
