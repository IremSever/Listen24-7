//
//  PlaylistModel.swift
//  Listen24-7
//
//  Created by İrem Sever on 3.04.2024.
//

import Foundation
// MARK: - PlaylistModel
struct PlaylistModel: Codable {
    let meta: Meta
    let data: PlaylistData
}

// MARK: - PlaylistData
struct PlaylistData: Codable {
    let list: PlaylistDetail
    
    enum CodingKeys: String, CodingKey {
        case list = "List"
    }
}
// MARK: - PlaylistDetail
struct PlaylistDetail: Codable {
    let pageInfo: PlaylistPageInfo
    let response: [PlaylistResponse]
    let status: Bool

    enum CodingKeys: String, CodingKey {
        case pageInfo = "PageInfo"
        case response = "Response"
        case status = "Status"
    }
}

// MARK: - PageInfo
struct PlaylistPageInfo: Codable {
    let siteTitle: String
    let siteURL: String

    enum CodingKeys: String, CodingKey {
        case siteTitle = "SiteTitle"
        case siteURL = "SiteUrl"
    }
}

// MARK: - Response
struct PlaylistResponse: Codable {
    let description: String
    let durationTimeInt: Int
    let followed: Bool
    let id: Int
    let image: String
    let imageAlternateText, listType, name: String
    let songCount: Int
    let songs: [PlaylistSongs]
    let url: String

    enum CodingKeys: String, CodingKey {
        case description = "Description"
        case durationTimeInt = "DurationTimeInt"
        case followed = "Followed"
        case id = "Id"
        case image, imageAlternateText
        case listType = "ListType"
        case name = "Name"
        case songCount = "SongCount"
        case songs = "Songs"
        case url = "Url"
    }
}

// MARK: - Song
struct PlaylistSongs: Codable {
    let album: Album
    let albumID: Int
    let durationTime: String
    let durationTimeInt: Int
    let favorited: Bool
    let id: Int
    let listType: ListType
    let lyrics: Lyrics
    let mp3URL: String
    let name: String
    let pageInfo: PageInfo
    let playerType: Int
    let playlists: [Playlist]
    let singers: [Playlist]
    let source: PlaylistSource
    let url: String

    enum CodingKeys: String, CodingKey {
        case album = "Album"
        case albumID = "AlbumId"
        case durationTime = "DurationTime"
        case durationTimeInt = "DurationTimeInt"
        case favorited = "Favorited"
        case id = "Id"
        case listType = "ListType"
        case lyrics = "Lyrics"
        case mp3URL = "Mp3Url"
        case name = "Name"
        case pageInfo = "PageInfo"
        case playerType = "PlayerType"
        case playlists = "Playlists"
        case singers = "Singers"
        case source = "Source"
        case url = "Url"
    }
}

enum Album: String, Codable {
    case album0 = "album://0"
}

enum ListType: String, Codable {
    case playlists = "Playlists"
}

// MARK: - Playlist
struct Playlist: Codable {
    let external: String?
    let id: Int?
    let image: String?
    let imageAlternateText, name: String?
    let gaType: String?

    enum CodingKeys: String, CodingKey {
        case external = "External"
        case id = "Id"
        case image, imageAlternateText
        case name = "Name"
        case gaType = "GAType"
    }
}

// MARK: - Source
struct PlaylistSource: Codable {
    let external: String
    let text: Text

    enum CodingKeys: String, CodingKey {
        case external = "External"
        case text = "Text"
    }
}

enum Text: String, Codable {
    case kaynağaGit = "Kaynağa Git"
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

