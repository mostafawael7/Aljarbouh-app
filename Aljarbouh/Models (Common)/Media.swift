//
//  Media.swift
//  Aljarbouh
//
//  Created by Hendawi on 26/04/2024.
//

import Foundation

struct Media: Codable {
    let id: Int?
    let modelType: String?
    let modelID: Int?
    let uuid: String?
    let collectionName: String?
    let name: String?
    let fileName: String?
    let mimeType: String?
    let disk: String?
    let conversionsDisk: String?
    let size: Int?
    let manipulations: [JSONAny]?
    let customProperties: [JSONAny]?
    let generatedConversions: [JSONAny]?
    let responsiveImages: [JSONAny]?
    let orderColumn: Int?
    let createdAt: String?
    let updatedAt: String?
    let originalURL: String?
    let previewURL: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case modelType = "model_type"
        case modelID = "model_id"
        case uuid = "uuid"
        case collectionName = "collection_name"
        case name = "name"
        case fileName = "file_name"
        case mimeType = "mime_type"
        case disk = "disk"
        case conversionsDisk = "conversions_disk"
        case size = "size"
        case manipulations = "manipulations"
        case customProperties = "custom_properties"
        case generatedConversions = "generated_conversions"
        case responsiveImages = "responsive_images"
        case orderColumn = "order_column"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case originalURL = "original_url"
        case previewURL = "preview_url"
    }
}


struct MediaShort: Codable{
    let url: String?
    let name: String?
}
