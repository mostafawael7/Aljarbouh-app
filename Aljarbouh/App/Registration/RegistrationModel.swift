//
//  LoginModel.swift
//  Aljarbouh
//
//  Created by Hendawi on 12/04/2024.
//

import Foundation

// MARK: - Login
struct GetLoginResponse: Codable {
    let success: Bool?
    let message: String?
    let data: LoginResponse?
}

// MARK: - DataClass
struct LoginResponse: Codable {
    let accessToken: String?
    let tokenType: String?
    let user: User?
    let profile: Profile?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case user = "user"
        case profile = "profile"
    }
    
    init() {
        self.accessToken = nil
        self.tokenType = nil
        self.user = nil
        self.profile = nil
    }
}

// MARK: - Profile
struct Profile: Codable {
    let id: Int?
    let firstName: String?
    let fatherName: String?
    let grandFatherName: String?
    let grand2FatherName: String?
    let dateOfBorn: String?
    let bornLocation: String?
    let image: String?
    let summary: String?
    let userID: Int?
    let status: String?
    let live: Int?
    let profission: String?
    let createdAt: String?
    let updatedAt: String?
    let residenceCountry: String?
    let bornCountry: String?
    let fatherFullName: String?
    let motherName: String?
    let email: String?
    let phone: String?
    let addressDetails: String?
    let socialStatus: String?
    let gender: Int?
    let generation: String?
    let age: Int?
    let family: [Family]?
    let media: [Media]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case fatherName = "father_name"
        case grandFatherName = "grand_father_name"
        case grand2FatherName = "grand2_father_name"
        case dateOfBorn = "date_of_born"
        case bornLocation = "born_location"
        case image = "image"
        case summary = "summary"
        case userID = "user_id"
        case status = "status"
        case live = "live"
        case profission = "profission"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case residenceCountry = "residence_country"
        case bornCountry = "born_country"
        case fatherFullName = "father_full_name"
        case motherName = "mother_name"
        case email = "email"
        case phone = "phone"
        case addressDetails = "address_details"
        case socialStatus = "social_status"
        case gender = "gender"
        case generation = "generation"
        case age = "age"
        case family = "family"
        case media = "media"
    }
    
    init() {
        self.id = nil
        self.firstName = nil
        self.fatherName = nil
        self.grandFatherName = nil
        self.grand2FatherName = nil
        self.dateOfBorn = nil
        self.bornLocation = nil
        self.image = nil
        self.summary = nil
        self.userID = nil
        self.status = nil
        self.live = nil
        self.profission = nil
        self.createdAt = nil
        self.updatedAt = nil
        self.residenceCountry = nil
        self.bornCountry = nil
        self.fatherFullName = nil
        self.motherName = nil
        self.email = nil
        self.phone = nil
        self.addressDetails = nil
        self.socialStatus = nil
        self.gender = nil
        self.generation = nil
        self.age = nil
        self.family = nil
        self.media = nil
    }
    
    // Function to return full name
    func getFullName() -> String {
        var fullName = ""
        
        if let firstName = firstName {
            fullName += firstName
        }
        if let fatherName = fatherName {
            fullName += " \(fatherName)"
        }
        if let grandFatherName = grandFatherName {
            fullName += " \(grandFatherName)"
        }
        if let grand2FatherName = grand2FatherName {
            fullName += " \(grand2FatherName)"
        }
        
        return fullName
    }
}

// MARK: - Family
struct Family: Codable {
    let relatedProfileID: Int?
    let relationType: String?
    let firstName: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case relatedProfileID = "related_profile_id"
        case relationType = "relation_type"
        case firstName = "first_name"
        case imageURL = "image_url"
    }
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name: String?
    let email: String?
    let phone: String?
    let emailVerifiedAt: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case phone = "phone"
        case emailVerifiedAt = "email_verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct GetProfileResponse: Codable {
    let success: Bool?
    let message: String?
    let data: Profile?
}

struct GetFamilyTreeResponse: Codable {
    let success: Bool?
    let message: String?
    let data: [Profile]?
}
