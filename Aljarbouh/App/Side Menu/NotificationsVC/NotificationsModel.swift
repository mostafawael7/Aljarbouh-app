//
//  NotificationsModel.swift
//  Aljarbouh
//
//  Created by Hendawi on 02/05/2024.
//

import Foundation

// MARK: - GetNotifications
struct GetNotificationsResponse: Codable {
    let success: Bool?
    let message: String?
    let data: [Notification]?
}

// MARK: - Notification
struct Notification: Codable {
    let id: Int?
    let message: String?
    let date: String?
    let time: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case message = "message"
        case date = "date"
        case time = "time"
        case imageURL = "image_url"
    }
}
