//
//  AppModel.swift
//  Listen24-7
//
//  Created by İrem Sever on 6.03.2024.
//

import Foundation

struct AppModel: Codable {
    let app: AppClass
}

struct AppClass: Codable {
    let response: [Response]
}

struct Response: Codable {
    let title: String
    let template: Template
    let cellType: String
    let playlist, selectMode: [Playlist]?
    let liveRadio, endlessMusic, sportAgenda, audiobook: [Audiobook]?
    let kpopFans, nostalgia, listenForMode, searching: [Audiobook]?
    let turkishRockForMode, top2023, remix, reggae: [Audiobook]?
    let literature, teamSongs: [Audiobook]?
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

struct Audiobook: Codable {
    let image: String
}

struct NewRelease: Codable {
    let title, image, duration: String
}

struct Playlist: Codable {
    let title, image: String
}

enum Template: String, Codable {
    case home = "home"
}

struct Weekly: Codable {
    let title, image, releaseDate: String
}

struct WeeklyTop10: Codable {
    let title, artist: String
}
