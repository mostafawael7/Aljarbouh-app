//
//  Heper.swift
//  Aljarbouh
//
//  Created by Hendawi on 21/02/2024.
//

import UIKit
import SystemConfiguration

class Helper{
    static let sharedHelper = Helper()
    
    // Function to check if the device is connected to a network
    func isConnectedToNetwork() -> Bool {
        
        // Create a sockaddr_in structure with zeros and address family AF_INET (IPv4)
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        // Set up SCNetworkReachability object using the created zeroAddress
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        // Variable to store network reachability flags
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        
        // Get network reachability flags and check for success
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Check if the device is reachable and does not require a connection. Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let isConnected = (isReachable && !needsConnection)
        
        return isConnected
    }

    func convertAnyToJSONString(_ object: Any) -> String? {
        do {
            // Convert the object to JSON data
            let jsonData = try JSONSerialization.data(withJSONObject: object, options: [])

            // Convert JSON data to a string
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            } else {
                print("Failed to convert JSON data to string.")
                return nil
            }
        } catch {
            print("Error converting object to JSON: \(error)")
            return nil
        }
    }
    
    func convertObjectToJSONString<T: Encodable>(object: T) -> String? {
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(object)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            } else {
                print("Failed to convert JSON data to string.")
                return nil
            }
        } catch {
            print("Error encoding object to JSON: \(error.localizedDescription)")
            return nil
        }
    }
}
