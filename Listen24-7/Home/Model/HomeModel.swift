//
//  Home.swift
//  Listen24-7
//
//  Created by IREM SEVER on 21.03.2024.
//

import Foundation
// MARK: - HomeModel
struct HomeModel: Codable {
    let meta: HomeMeta
    let data: HomeData
}

// MARK: - DataClass
struct HomeData: Codable {
    let list: List?
}

// MARK: - List
struct List: Codable {
    let pageInfo: PageInfo?
    let response: [Response]?
    let status: Bool?

    enum CodingKeys: String, CodingKey {
        case pageInfo = "PageInfo"
        case response = "Response"
        case status = "Status"
    }
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let siteTitle: String
    let siteURL: String

    enum CodingKeys: String, CodingKey {
        case siteTitle = "SiteTitle"
        case siteURL = "SiteUrl"
    }
}

// MARK: - Response
struct Response: Codable {
    let listType, name: String?
    let playlists: [CategoryGroup]?
    let template: String?
    let radioChannels: [RadioChannel]?
    let showMore: Bool?
    let showMoreExternal: String?
    let categoryGroups: [CategoryGroup]?
    let songs: [Song]?

    enum CodingKeys: String, CodingKey {
        case listType = "ListType"
        case name = "Name"
        case playlists = "Playlists"
        case template = "Template"
        case radioChannels = "RadioChannels"
        case showMore = "ShowMore"
        case showMoreExternal = "ShowMoreExternal"
        case categoryGroups = "CategoryGroups"
        case songs = "Songs"
    }
}

// MARK: - CategoryGroup
struct CategoryGroup: Codable {
    let external: String?
    let id: Int?
    let image: String?
    let imageAlternateText, name: String?
    let url: String?
    let description: String?
    let followed: Bool?
    let gaType: String?

    enum CodingKeys: String, CodingKey {
        case external = "External"
        case id = "Id"
        case image, imageAlternateText
        case name = "Name"
        case url = "Url"
        case description = "Description"
        case followed = "Followed"
        case gaType = "GAType"
    }
}

// MARK: - RadioChannel
struct RadioChannel: Codable {
    let id: Int?
    let image: String?
    let imageAlternateText: String?
    let mp3URL: String?
    let name: String?
    let pageInfo: PageInfo?
    let playerType: Int?
    let trackPort: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case image, imageAlternateText
        case mp3URL = "MP3Url"
        case name = "Name"
        case pageInfo = "PageInfo"
        case playerType = "PlayerType"
        case trackPort = "TrackPort"
        case url = "Url"
    }
}

// MARK: - Song
struct Song: Codable {
    let advertorial: Advertorial?
    let durationTime: String?
    let durationTimeInt: Int?
    let favorited: Bool?
    let id: Int?
    let image: String?
    let imageAlternateText: String?
    let listType: String?
    let lyrics: Lyrics?
    let mp3URL: String?
    let name: String?
    let pageInfo: PageInfo?
    let playerType: Int?
    let playlists: [CategoryGroup]?
    let publishDate: String?
    let singers: [CategoryGroup]?
    let source: Source?
    let spot, spotShort: String?
    let url: String?
    let album: String?
    let albumID: Int?

    enum CodingKeys: String, CodingKey {
        case advertorial = "Advertorial"
        case durationTime = "DurationTime"
        case durationTimeInt = "DurationTimeInt"
        case favorited = "Favorited"
        case id = "Id"
        case image, imageAlternateText
        case listType = "ListType"
        case lyrics = "Lyrics"
        case mp3URL = "Mp3Url"
        case name = "Name"
        case pageInfo = "PageInfo"
        case playerType = "PlayerType"
        case playlists = "Playlists"
        case publishDate = "PublishDate"
        case singers = "Singers"
        case source = "Source"
        case spot = "Spot"
        case spotShort = "SpotShort"
        case url = "Url"
        case album = "Album"
        case albumID = "AlbumId"
    }
}

// MARK: - Advertorial
struct Advertorial: Codable {
    let postrollFrequency: Int?
    let preroll: String?
    let prerollFrequency: Int?
    let prerollV2: PrerollV2?

    enum CodingKeys: String, CodingKey {
        case postrollFrequency = "PostrollFrequency"
        case preroll = "Preroll"
        case prerollFrequency = "PrerollFrequency"
        case prerollV2 = "PrerollV2"
    }
}

// MARK: - PrerollV2
struct PrerollV2: Codable {
    let android, ios: Android

    enum CodingKeys: String, CodingKey {
        case android = "Android"
        case ios = "IOS"
    }
}

// MARK: - Android
struct Android: Codable {
    let code: String
    let isActive: Bool

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case isActive = "IsActive"
    }
}

// MARK: - Lyrics
struct Lyrics: Codable {
    let composerName, lyricistName, text: String?

    enum CodingKeys: String, CodingKey {
        case composerName = "ComposerName"
        case lyricistName = "LyricistName"
        case text = "Text"
    }
}

// MARK: - Source
struct Source: Codable {
    let external: String
    let text: String

    enum CodingKeys: String, CodingKey {
        case external = "External"
        case text = "Text"
    }
}

// MARK: - Meta
struct HomeMeta: Codable {
    let statusCode: Int
    let message, description, brand: String

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, description, brand
    }
}
