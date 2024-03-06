//
//  AppModel.swift
//  Listen24-7
//
//  Created by İrem Sever on 6.03.2024.
//

import Foundation


// MARK: - Welcome
struct Welcome: Codable {
    let meta: Meta
    let data: AppModel
}

// MARK: - DataClass
struct AppModel: Codable {
    let app: [App]
}

// MARK: - App
struct App: Codable {
    let popular: [Popular]?
    let selectMode: [SelectMode]?
    
    enum CodingKeys: String, CodingKey {
        case popular
        case selectMode = "select_mode"
    }
}

// MARK: - Popular
struct Popular: Codable {
    let title: String
    let image: String
    let category, detail, artist: String?
    let songs: [Song]?
}

// MARK: - Song
struct Song: Codable {
    let title, duration, filePath: String
    let artist: String?
    
    enum CodingKeys: String, CodingKey {
        case title, duration
        case filePath = "file_path"
        case artist
    }
}

// MARK: - SelectMode
struct SelectMode: Codable {
    let title, image, details: String
    let songs: [Song]
}

// MARK: - Meta
struct Meta: Codable {
    let statusCode: Int
    let message, description, brand: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, description, brand
    }
}

