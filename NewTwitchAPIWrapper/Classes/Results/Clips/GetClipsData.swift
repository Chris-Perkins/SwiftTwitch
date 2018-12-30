//
//  GetClipsData.swift
//  NewTwitchAPIWrapper
//
//  Created by Christopher Perkins on 12/29/18.
//

import Marshal

/// `GetClipsData` is a class that encapsulates all of the information of a single returned clip
/// from the returned array of Clip data from the New Twitch API's `Get Clips` call.
public struct GetClipsData: Unmarshaling {
    
    /// `clipData` specifies the data of the clips that was retrieved from the API call.
    public let clipData: [GetClipsClipData]
    
    /// `paginationToken` defines the token that allows for the pagination of results in the
    /// `Get Clips` API call.
    public let paginationToken: String?
    
    /// Initializes a `GetsClipsData` object from the input `MarshaledObject`. This will throw
    /// if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `GetClips` piece from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        clipData = try object.value(for: Twitch.WebRequestKeys.data)
        paginationToken = try? object.value(for: Twitch.WebRequestKeys.pagination)
    }
}
