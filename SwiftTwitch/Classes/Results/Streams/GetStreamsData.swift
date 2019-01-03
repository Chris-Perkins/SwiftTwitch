//
//  GetStreamsData.swift
//  Marshal
//
//  Created by Christopher Perkins on 12/30/18.
//

import Marshal

/// `GetStreamsData` is a class that is used to provide a robust interface for data received
/// from the `Get Streams` call of the New Twitch API.
public struct GetStreamsData: Unmarshaling {

    /// `streamData` specifies the data of the streams that was retrieved from the API call.
    public let streamData: [StreamData]

    /// `paginationData` defines the token that allows for the pagination of results in the
    /// `Get Streams` call.
    public let paginationData: PaginationData?

    /// Initializes a `GetStreamsData` object from the input `MarshaledObject`. This will throw
    /// if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `GetStreamsData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        streamData = try object.value(for: Twitch.WebRequestKeys.data)
        paginationData = try? object.value(for: Twitch.WebRequestKeys.pagination)
    }
}
