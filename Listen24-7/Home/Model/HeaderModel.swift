//
//  Header.swift
//  Listen24-7
//
//  Created by IREM SEVER on 21.03.2024.
//

import Foundation

// MARK: - HeaderModel
struct HeaderModel: Codable {
    let meta: HeaderMeta
    let data: HeaderData
}

// MARK: - HeaderData
struct HeaderData: Codable {
    let news: News
}

// MARK: - News
struct News: Codable {
    let pageInfo: JSONHeaderNull?
    let response: [HeaderResponse]?
    let status: Bool

    enum CodingKeys: String, CodingKey {
        case pageInfo = "PageInfo"
        case response = "Response"
        case status = "Status"
    }
}

// MARK: - Response
struct HeaderResponse: Codable {
    let articleID, description, external, id: String?
    let image: String?
    let imageAlternateText, modifiedDate: String?
    let richTextActive, showWebView: Bool?
    let spot, spotShort: String?
    let surmansetBaslik, surmansetBaslikKategori: Bool?
    let title, titleShort: String?
    let url: String?
    let usedMethod: Bool?

    enum CodingKeys: String, CodingKey {
        case articleID = "ArticleId"
        case description = "Description"
        case external = "External"
        case id = "Id"
        case image = "Image"
        case imageAlternateText = "ImageAlternateText"
        case modifiedDate = "ModifiedDate"
        case richTextActive = "RichTextActive"
        case showWebView = "ShowWebView"
        case spot = "Spot"
        case spotShort = "SpotShort"
        case surmansetBaslik = "SurmansetBaslik"
        case surmansetBaslikKategori = "SurmansetBaslikKategori"
        case title = "Title"
        case titleShort = "TitleShort"
        case url = "Url"
        case usedMethod = "UsedMethod"
    }
}

// MARK: - Meta
struct HeaderMeta: Codable {
    let statusCode: Int
    let message, description, brand: String

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, description, brand
    }
}

// MARK: - Encode/decode helpers
class JSONHeaderNull: Codable, Hashable {
    static func == (lhs: JSONHeaderNull, rhs: JSONHeaderNull) -> Bool {
        return true
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONHeaderNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
