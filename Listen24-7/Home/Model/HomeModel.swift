//
//  Home.swift
//  Listen24-7
//
//  Created by IREM SEVER on 21.03.2024.
//

import Foundation

struct HomeModel: Codable {
    let meta: HomeMeta
    let data: HomeData
}

struct HomeData: Codable {
    let list: List
}

struct List: Codable {
    let pageInfo: PageInfo
    let response: [Response]
    let status: Bool

    enum CodingKeys: String, CodingKey {
        case pageInfo = "PageInfo"
        case response = "Response"
        case status = "Status"
    }
}

struct PageInfo: Codable {
    let siteTitle: String
    let siteURL: String

    enum CodingKeys: String, CodingKey {
        case siteTitle = "SiteTitle"
        case siteURL = "SiteUrl"
    }
}

struct Response: Codable {
    let listType, name: String
    let playlists: [CategoryGroup]?
    let showMore: Bool?
    let showMoreExternal: String?
    let template: String
    let radioChannels: [RadioChannel]?
    let categoryGroups: [CategoryGroup]?
    let songs: [Song]?

    enum CodingKeys: String, CodingKey {
        case listType = "ListType"
        case name = "Name"
        case playlists = "Playlists"
        case showMore = "ShowMore"
        case showMoreExternal = "ShowMoreExternal"
        case template = "Template"
        case radioChannels = "RadioChannels"
        case categoryGroups = "CategoryGroups"
        case songs = "Songs"
    }
}

struct CategoryGroup: Codable {
    let external: String
    let id: Int
    let image: String
    let imageAlternateText, name: String
    let url: String?
    let description: String?
    let followed: Bool?
    let gaType: GAType?

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

enum GAType: String, Codable {
    case news = "News"
    case podcast = "Podcast"
    case singer = "Singer"
}

struct RadioChannel: Codable {
    let id: Int
    let image: String
    let imageAlternateText: String
    let mp3URL: String
    let name: String
    let pageInfo: PageInfo
    let playerType: Int
    let trackPort: String
    let url: String

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

struct Song: Codable {
    let advertorial: Advertorial
    let album: String?
    let albumID: Int?
    let durationTime: String
    //let durationTimeInt: Int
    let favorited: Bool
    let id: Int
    let image: String
    //let imageAlternateText: String
    let listType: ListType
    let lyrics: Lyrics
    let mp3URL: String
    let name: String
    let pageInfo: PageInfo
    let playerType: Int
    let playlists: [CategoryGroup]
    //let publishDate: String?
    let singers: [CategoryGroup]
    let source: Source
    let spot: String?
    //let spotShort: String?
    let url: String

    enum CodingKeys: String, CodingKey {
        case advertorial = "Advertorial"
        case album = "Album"
        case albumID = "AlbumId"
        case durationTime = "DurationTime"
        //case durationTimeInt = "DurationTimeInt"
        case favorited = "Favorited"
        case id = "Id"
        case image
        //case imageAlternateText
        case listType = "ListType"
        case lyrics = "Lyrics"
        case mp3URL = "Mp3Url"
        case name = "Name"
        case pageInfo = "PageInfo"
        case playerType = "PlayerType"
        case playlists = "Playlists"
        //case publishDate = "PublishDate"
        case singers = "Singers"
        case source = "Source"
        case spot = "Spot"
        //case spotShort = "SpotShort"
        case url = "Url"
    }
}

struct Advertorial: Codable {
    //let postroll: JSONNull?
    let postrollFrequency: Int
    //let postrollV2: JSONNull?
    let preroll: String
    let prerollFrequency: Int
    let prerollV2: PrerollV2

    enum CodingKeys: String, CodingKey {
        //case postroll = "Postroll"
        case postrollFrequency = "PostrollFrequency"
        //case postrollV2 = "PostrollV2"
        case preroll = "Preroll"
        case prerollFrequency = "PrerollFrequency"
        case prerollV2 = "PrerollV2"
    }
}

struct PrerollV2: Codable {
    let android, ios: Android

    enum CodingKeys: String, CodingKey {
        case android = "Android"
        case ios = "IOS"
    }
}

struct Android: Codable {
    let code: String
    let isActive: Bool

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case isActive = "IsActive"
    }
}

enum ListType: String, Codable {
    case playlists = "Playlists"
}

struct Lyrics: Codable {
    let composerName, lyricistName, text: String?

    enum CodingKeys: String, CodingKey {
        case composerName = "ComposerName"
        case lyricistName = "LyricistName"
        case text = "Text"
    }
}

struct Source: Codable {
    let external: String
    let text: Text

    enum CodingKeys: String, CodingKey {
        case external = "External"
        case text = "Text"
    }
}

enum Text: String, Codable {
    case kaynağaGit = "Kaynağa Git"
    case şarkıcıyaGit = "Şarkıcıya Git"
}

struct HomeMeta: Codable {
    let statusCode: Int
    let message, description, brand: String

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, description, brand
    }
}

/*class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}*/
