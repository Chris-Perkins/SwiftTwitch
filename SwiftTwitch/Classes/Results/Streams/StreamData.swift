//
//  StreamData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Marshal

/// `StreamData` is a class that encapsulates all of the information of a single returned stream
/// from the returned array of Stream data from the New Twitch API's `Streams` methods.
public struct StreamData: Unmarshaling {
    
    /// StreamType defines the different states of being that a Stream can be in.
    ///
    /// - live: Defines that the stream is currently live
    /// - error: Defines that an error occurred while retrieving this Stream's state.
    public enum StreamType: String {
        case live = "live"
        case error = ""
    }
    
    /// `streamId` specifies the ID of the stream.
    public let streamId: String
    
    /// `streamerId` specifies the ID of the streamer.
    public let streamerId: String
    
    /// `streamerUserName` specifies the username of the streamer.
    public let streamerUserName: String
    
    /// `gameId` specifies the ID of the game being streamed.
    public let gameId: String?

    /// `communityIds` specifies the communities that this stream is a part of.
    public let communityIds: [String]
    
    /// `streamType` specifies whether the stream is live or if an error occurred.
    public let streamType: StreamType
    
    /// `title` specifies the title of the stream.
    public let title: String
    
    /// `startTime` defines when the stream session started.
    public let startTime: Date

    /// `language` specifies the language of the stream.
    public let language: String

    /// `thumbnailURLString` specifies the URL as a String of the clip thumbnail. To convert this
    /// to a real URL, you must replace the `%{width}` and `%{height}` substrings that are present
    /// in this String.
    public let thumbnailURLString: String

    /// `viewCounert` specifies the amount of views this stream has.
    public let viewerCount: Int
    
    /// Initializes a `StreamData` object from the input `MarshaledObject`. This will throw if there
    /// is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `StreamData` piece from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        streamId = try object.value(for: Twitch.WebRequestKeys.id)
        streamerId = try object.value(for: Twitch.WebRequestKeys.userId)
        streamerUserName = try object.value(for: Twitch.WebRequestKeys.userName)
        gameId = try? object.value(for: Twitch.WebRequestKeys.gameId)
        communityIds = try object.value(for: Twitch.WebRequestKeys.communityIds)
        streamType = try object.value(for: Twitch.WebRequestKeys.type)
        title = try object.value(for: Twitch.WebRequestKeys.title)
        startTime = try object.value(for: Twitch.WebRequestKeys.startedAt)
        language = try object.value(for: Twitch.WebRequestKeys.language)
        thumbnailURLString = try object.value(for: Twitch.WebRequestKeys.thumbnailURL)
        viewerCount = try object.value(for: Twitch.WebRequestKeys.viewerCount)
        
    }
}
