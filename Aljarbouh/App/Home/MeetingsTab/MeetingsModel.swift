//
//  MeetingsModel.swift
//  Aljarbouh
//
//  Created by Hendawi on 28/04/2024.
//

import Foundation

// MARK: - GetMeetings
struct GetMeetings: Codable {
    let success: Bool?
    let message: String?
    let data: [Meeting]?
}

// MARK: - Meeting
struct Meeting: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let lat: String?
    let long: String?
    let image: String?
    let date: String?
    let userID: Int?
    let createdAt: String?
    let updatedAt: String?
    let hijriDate: String?
    let attendees: [JSONAny]?
    let media: [Media]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case lat = "lat"
        case long = "long"
        case image = "image"
        case date = "date"
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hijriDate = "hijri_date"
        case attendees = "attendees"
        case media = "media"
    }
    
    init() {
        self.id = nil
        self.title = nil
        self.description = nil
        self.lat = nil
        self.long = nil
        self.image = nil
        self.date = nil
        self.userID = nil
        self.createdAt = nil
        self.updatedAt = nil
        self.hijriDate = nil
        self.attendees = nil
        self.media = nil
    }
}
