//
//  GetVideosResult.swift
//  Marshal
//
//  Created by Christopher Perkins on 1/1/19.
//

import Marshal

/// `GetVideosData` is a class that encapsulates all of the information of a single returned clip
/// from the returned array of Clip data from the New Twitch API's `Get Videos` call.
public struct GetVideosData: Unmarshaling {

    /// `clipData` specifies the data of the Videos that was retrieved from the API call.
    public let videoData: [VideoData]

    /// `paginationData` defines the token that allows for the pagination of results in the
    /// `Get Videos` call.
    public let paginationData: PaginationData?

    /// Initializes a `GetsVideosData` object from the input `MarshaledObject`. This will throw
    /// if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `GetVideosData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        videoData = try object.value(for: Twitch.WebRequestKeys.data)
        paginationData = try? object.value(for: Twitch.WebRequestKeys.pagination)
    }
}
