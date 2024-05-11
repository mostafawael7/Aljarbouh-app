//
//  BanksModel.swift
//  Aljarbouh
//
//  Created by Hendawi on 02/05/2024.
//

import Foundation

// MARK: - GetBanksResponse
struct GetBanksResponse: Codable {
    let success: Bool?
    let message: String?
    let data: [Bank]?
}

// MARK: - Bank
struct Bank: Codable {
    let id: Int?
    let image: String?
    let title: String?
    let description: String?
    let iban: String?
    let type: String?
    let accountNumber: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
        case title = "title"
        case description = "description"
        case iban = "iban"
        case type = "type"
        case accountNumber = "account_number"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
