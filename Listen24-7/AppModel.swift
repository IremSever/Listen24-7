//
//  AppModel.swift
//  Listen24-7
//
//  Created by İrem Sever on 6.03.2024.
//

import Foundation

struct AppModel: Codable {
    let app: AppData
}

struct AppData: Codable {
    let response: [ResponseDetails]
}

struct ResponseDetails: Codable {
    let title: String?
    let template: String?
    let playlist: [PlaylistItem]?
    let select_mode: [SelectModeItem]?
    let live_radio: [LiveRadioItem]?
    let endless_music: [EndlessMusicItem]?
    let sport_agenda: [SportAgendaItem]?
    let audiobook: [AudiobookItem]?
    let kpop_fans: [KpopFansItem]?
    let nostalgia: [NostalgiaItem]?
    let listen_for_mode: [ListenForModeItem]?
    let searching: [SearchingItem]?
    let turkish_rock_for_mode: [TurkishRockForModeItem]?
    let top_2023: [Top2023Item]?
    let remix: [RemixItem]?
    let reggae: [ReggaeItem]?
    let literature: [LiteratureItem]?
    let team_songs: [TeamSongsItem]?
    let weekly_suggestions: [WeeklySuggestionsItem]?
    let new_releases: [NewReleasesItem]?
    let weekly_fav_albums: [WeeklyFavAlbumsItem]?
    let children_library: [ChildrenLibraryItem]?
    let weekly_top10: [WeeklyTop10Item]?
}

struct PlaylistItem: Codable {
    let title: String
    let image: String
}

struct SelectModeItem: Codable {
    let title: String
    let image: String
}

struct LiveRadioItem: Codable {
    let image: String
}

struct EndlessMusicItem: Codable {
    let image: String
}

struct SportAgendaItem: Codable {
    let image: String
}

struct AudiobookItem: Codable {
    let image: String
}

struct KpopFansItem: Codable {
    let image: String
}

struct NostalgiaItem: Codable {
    let image: String
}

struct ListenForModeItem: Codable {
    let image: String
}

struct SearchingItem: Codable {
    let image: String
}

struct TurkishRockForModeItem: Codable {
    let image: String
}

struct Top2023Item: Codable {
    let image: String
}

struct RemixItem: Codable {
    let image: String
}

struct ReggaeItem: Codable {
    let image: String
}

struct LiteratureItem: Codable {
    let image: String
}

struct TeamSongsItem: Codable {
    let image: String
}

struct WeeklySuggestionsItem: Codable {
    let title: String
    let image: String
    let releaseDate: String
}

struct NewReleasesItem: Codable {
    let title: String
    let image: String
    let duration: String?
}

struct WeeklyFavAlbumsItem: Codable {
    let title: String
    let image: String
    let releaseDate: String
}

struct ChildrenLibraryItem: Codable {
    let image: String
}

struct WeeklyTop10Item: Codable {
    let title: String
    let artist: String
}

