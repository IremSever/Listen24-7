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
    let response: [HeaderResponse]?
    let status: Bool

    enum CodingKeys: String, CodingKey {
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
