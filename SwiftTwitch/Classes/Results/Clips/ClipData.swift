//
//  ClipData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/29/18.
//

import Marshal

/// `ClipData` is a class that encapsulates all of the information of a single returned clip from
/// the returned array of Clip data from the New Twitch API's `Clips` methods.
public struct ClipData: Unmarshaling {

    /// `broadcasterId` specifies the ID of the user from whose stream the clip was taken from.
    public let broadcasterId: String

    /// `broadcasterName` specifies the name of the user from whose stream the clip was taken from.
    public let broadcasterName: String

    /// `creationDate` specifies when the clip was created.
    public let creationDate: Date

    /// `creatorId` specifies the ID of the user from who created the clip.
    ///
    /// - Note: This shares **no relationship** with the broadcaster from whose stream the clip was
    /// from. See `broadcasterId` for that property instead.
    public let creatorId: String
    
    /// `creatorName` specifies the name of the user who created the clip.
    ///
    /// - Note: This shares **no relationship** with the broadcaster from whose stream the clip was
    /// from. See `broadcasterName` for that property instead.
    public let creatorName: String
    
    /// `embedURL` specifies the URL for which you can embed this clip into your application.
    public let embedURL: URL
    
    /// `gameId` specifies the ID of the game from which the clip was taken from.
    public let gameId: String
    
    /// `clipId` specifies the ID of the clip.
    public let clipId: String
    
    /// `language` specifies the language of the stream when the clip was created.
    public let language: String
    
    /// `thumbnailURL` specifies the URL of the clip thumbnail.
    public let thumbnailURL: URL
    
    /// `title` specifies the title of the clip.
    public let title: String
    
    /// `clipURL` specifies the URL where the clip can be viewed.
    ///
    /// - Note: This is **not** the same as the url to embed the clip.
    public let clipURL: URL
    
    /// `videoId` specifies the ID of the stream/video from which this clip was taken from.
    public let videoId: String
    
    /// `viewCount` specifies the amount of views this clip has.
    public let viewCount: Int
    
    /// Initializes a `ClipData` object from the input `MarshaledObject`. This will throw if there
    /// is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `ClipData` piece from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        broadcasterId = try object.value(for: Twitch.WebRequestKeys.broadcasterId)
        broadcasterName = try object.value(for: Twitch.WebRequestKeys.broadcasterName)
        creationDate = try object.value(for: Twitch.WebRequestKeys.createdAt)
        creatorId = try object.value(for: Twitch.WebRequestKeys.creatorId)
        creatorName = try object.value(for: Twitch.WebRequestKeys.creatorName)
        embedURL = try object.value(for: Twitch.WebRequestKeys.embedURL)
        gameId = try object.value(for: Twitch.WebRequestKeys.gameId)
        clipId = try object.value(for: Twitch.WebRequestKeys.id)
        language = try object.value(for: Twitch.WebRequestKeys.language)
        thumbnailURL = try object.value(for: Twitch.WebRequestKeys.thumbnailURL)
        title = try object.value(for: Twitch.WebRequestKeys.title)
        clipURL = try object.value(for: Twitch.WebRequestKeys.url)
        videoId = try object.value(for: Twitch.WebRequestKeys.videoId)
        viewCount = try object.value(for: Twitch.WebRequestKeys.viewCount)
    }
}
