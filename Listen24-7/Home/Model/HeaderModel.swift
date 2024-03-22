//
//  Header.swift
//  Listen24-7
//
//  Created by IREM SEVER on 21.03.2024.
//

import Foundation

struct HeaderModel: Codable {
    let meta: HeaderMeta
    let data: HeaderData
}

struct HeaderData: Codable {
    let news: News
}

struct News: Codable {
    //let pageInfo: JSONNull?
    let response: [HeaderResponse]
    let status: Bool

    enum CodingKeys: String, CodingKey {
        //case pageInfo = "PageInfo"
        case response = "Response"
        case status = "Status"
    }
}

struct HeaderResponse: Codable {
    let articleID: String?
    let description: String?
    let external: String?
    let id: String?
    let image: String?
    //let imageAlternateText: String?
    //let modifiedDate: String?
    //let richTextActive: Bool?
    //let showWebView: Bool?
    let spot: String?
    //let spotShort: String?
    //let surmansetBaslik: Bool?
    //let surmansetBaslikKategori: Bool?
    let title: String?
    //let titleShort: String?
    let url: String?
    //let usedMethod: Bool?

    enum CodingKeys: String, CodingKey {
        case articleID = "ArticleId"
        case description = "Description"
        case external = "External"
        case id = "Id"
        case image
        //case imageAlternateText
        //case modifiedDate = "ModifiedDate"
        //case richTextActive = "RichTextActive"
        //case showWebView = "ShowWebView"
        case spot = "Spot"
        //case spotShort = "SpotShort"
        //case surmansetBaslik = "SurmansetBaslik"
        //case surmansetBaslikKategori = "SurmansetBaslikKategori"
        case title = "Title"
        //case titleShort = "TitleShort"
        case url = "Url"
        //case usedMethod = "UsedMethod"
    }
}

struct HeaderMeta: Codable {
    let statusCode: Int
    let message, description, brand: String

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, description, brand
    }
}


