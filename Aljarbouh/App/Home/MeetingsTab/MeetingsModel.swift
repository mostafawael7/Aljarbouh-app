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
    let address: String?
    let lat: String?
    let long: String?
    let date: String?
    let hours: String?
    let hijriDate: String?
    let attendees: [Attendee]?
    let media: [MediaShort]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case address = "address"
        case lat = "lat"
        case long = "long"
        case date = "date"
        case hours = "hours"
        case hijriDate = "hijri_date"
        case attendees = "attendees"
        case media = "media"
    }
    
    init() {
        self.id = nil
        self.title = nil
        self.description = nil
        self.address = nil
        self.lat = nil
        self.long = nil
        self.date = nil
        self.hours = nil
        self.hijriDate = nil
        self.attendees = nil
        self.media = nil
    }
}

// MARK: - Attendee
struct Attendee: Codable {
    let userID: Int?
    let name: String?
    let profession: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name = "name"
        case profession = "profession"
        case imageURL = "image_url"
    }
}
