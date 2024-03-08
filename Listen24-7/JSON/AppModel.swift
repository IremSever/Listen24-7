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

// MARK: - App
struct App: Codable {
    let response: [Response]
}

// MARK: - Response
struct Response: Codable {
    let title: String
    let template: Template
    let cellType: CellType
    let playlist, selectMode, endlessMusic, teamSongs: [Playlist]?
    let sportAgenda, audiobook: [Audiobook]?
    let kpopFans, nostalgia, listenForMode, searching: [Playlist]?
    let turkishRockForMode, top2023, remix, reggae: [Playlist]?
    let literature: [Audiobook]?
    let liveRadio: [Radio]?
    let weeklySuggestions: [Weekly]?
    let newReleases: [NewRelease]?
    let weeklyFavAlbums: [Weekly]?
    let childrenLibrary: [Audiobook]?
    let weeklyTop10: [WeeklyTop10]?

    enum CodingKeys: String, CodingKey {
        case title, template, cellType, playlist
        case selectMode = "select_mode"
        case liveRadio = "live_radio"
        case endlessMusic = "endless_music"
        case sportAgenda = "sport_agenda"
        case audiobook
        case kpopFans = "kpop_fans"
        case nostalgia
        case listenForMode = "listen_for_mode"
        case searching
        case turkishRockForMode = "turkish_rock_for_mode"
        case top2023 = "top_2023"
        case remix, reggae, literature
        case teamSongs = "team_songs"
        case weeklySuggestions = "weekly_suggestions"
        case newReleases = "new_releases"
        case weeklyFavAlbums = "weekly_fav_albums"
        case childrenLibrary = "children_library"
        case weeklyTop10 = "weekly_top10"
    }
}

// MARK: - Audiobook
struct Audiobook: Codable {
    let image: String
}

// MARK: - NewRelease
struct NewRelease: Codable {
    let title, image, duration: String
}

// MARK: - Playlist
struct Playlist: Codable {
    let title: String?
    let image: String
}

enum Template: String, Codable {
    case home = "home"
}

// MARK: - Weekly
struct Weekly: Codable {
    let title, image, releaseDate: String
}

// MARK: - WeeklyTop10
struct WeeklyTop10: Codable {
    let title, artist: String
}
// MARK: - WeeklyTop10
struct Radio: Codable {
    let image: String
}

enum CellType: String, Codable {
    case cell_square = "square"
    case cell_circle = "circle"
    case cell_headline = "headline"
    case cell_latest = "latest"
    case cell_top10 = "top10"
    case cell_suggestion = "suggestion"
}
