//
//  AppModel.swift
//  Listen24-7
//
//  Created by İrem Sever on 6.03.2024.
//

import Foundation

struct AppModel: Codable {
    let app: App
}

struct App: Codable {
    let response: [Response]
}

struct Response: Codable {
    let title: String
    let template: Template
    let info: Info
    let playlist, selectMode, liveRadio, weeklySuggestions,
        newReleases, weeklyFavAlbums, weeklyTop10: [Info]?

    enum CodingKeys: String, CodingKey {
        case title, template, info, playlist, selectMode, liveRadio, weeklySuggestions,
             newReleases, weeklyFavAlbums, weeklyTop10
    }
}

enum Template: String, Codable {
    case cell_square
    case cell_headline
    case cell_circle
    case cell_suggestion
    case cell_latest
    case cell_top10
}

struct Info: Codable {
    let title: String?
    let image: String?
    let duration: String?
    let releaseDate: String?
    let artist: String?
}
// headline playlist, select mode square, newreaaleses lastest, favalbums suggestion
