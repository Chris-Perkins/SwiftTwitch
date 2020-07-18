//
//  VideoData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 1/1/19.
//

import Foundation

/// `VideoData` defines the data that belongs to a specific Video as retrieved from the `New Twitch
/// API` endpoint.
public struct VideoData: Codable {

    /// `VideoType` defines the different types of videos that are able to be posted on Twitch.
    ///
    /// - archive: `archive` defines a Video that was from a past livestream the uploader had.
    /// - highlight: `highlight` defines a Video that was a highlight of a past livestream the
    /// uploader had.
    /// - upload: `upload` defines a Video that was uploaded to Twitch
    public enum VideoType: String, Codable {
        case archive = "archive"
        case highlight = "highlight"
        case upload = "upload"
    }

    /// `ViewSettings` define the access-scope of the Video that was uploaded.
    ///
    /// - privateVideo: `privateVideo` defines that the video is private; only a select group of
    /// users are able to view the video.
    /// - publicVideo: `publicVideo` defines that the video is public; anyone can see the video.
    public enum ViewSettings: String, Codable {
        case privateVideo = "private"
        case publicVideo = "public"
    }

    /// `id` specifies the ID of the video on Twitch
    public let id: String

    /// `ownerId` is the ID of the user who owns the video.
    public let ownerId: String

    /// `ownerName` is the name of the user who owns the video.
    public let ownerName: String

    /// `title` is the title of the video on Twitch.
    public let title: String

    /// `description` is the description of the video on Twitch.
    public let description: String

    /// `creationDate` is the date on which the video was created on Twitch.
    public let creationDate: Date

    /// `publishedDate` is the date on which the video was published on Twitch.
    public let publishedDate: Date

    /// `url` is the URL where the video can be located at.
    public let url: URL

    /// `thumbnailURLString` is the URL of the video as a String. It contains text `%{height}` and
    /// `%{width}` that need to be replaced in order to be a valid URL
    public let thumbnailURLString: String

    /// `viewSetting` is the current settings of the video for viewing.
    ///
    /// - seealso: ViewSettings
    public let viewSetting: ViewSettings

    /// `viewCount` specifies the number of views the video has on Twitch.
    public let viewCount: Int

    /// `language` specifies the language that the video was recorded in.
    public let language: String

    /// `videoType` specifies the type of video this video is. E.g.: Stream Highlight.
    ///
    /// - seealso: VideoType
    public let videoType: VideoType

    // TODO: Can we just make this an `Int` value instead?
    /// `durationString` defines the duration of the video as a String in a `HH'h'mm'm'ss's' format.
    public let durationString: String

}
