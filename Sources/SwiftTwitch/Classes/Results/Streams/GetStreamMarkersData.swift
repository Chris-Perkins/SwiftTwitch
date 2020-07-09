//
//  GetStreamMarkersData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Marshal

/// `GetStreamMarkersData` is a class that is used to provide a robust interface for data received
/// from the `Get Streams` call of the New Twitch API.
public struct GetStreamMarkersData: Unmarshaling {

    /// `markedStreamers` specifies the streamers who have marked videos.
    public let markedStreamers: [MarkedStreamerData]

    /// `paginationData` defines the token that allows for the pagination of results in the
    /// `Get Streams Metadata` call.
    public let paginationData: PaginationData?

    /// Initializes a `GetStreamsMetadata` object from the input `MarshaledObject`. This will throw
    /// if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `GetStreamsMetadata` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        markedStreamers = try object.value(for: Twitch.WebRequestKeys.data)
        paginationData = try? object.value(for: Twitch.WebRequestKeys.pagination)
    }
}

