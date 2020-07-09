//
//  CreateClipData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/29/18.
//

import Marshal

/// `CreateClipData` is a class that is used to provide a robust interface for data received
/// from the `Create Clip` call of the New Twitch API. This object only has one property;
/// `clipsInfo`.
public struct CreateClipData: Unmarshaling {

    /// `clipsInfo` specifies the received data from `Create Clip` API calls. This will contain the
    /// actual clip information from the post response.
    public let clipsInfo: [GetBitsLeaderboardUserData]

    /// Initializes a `CreateClipData` object from the input `MarshaledObject`. This will throw if
    /// there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `CreateClipData` piece from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        clipsInfo = try object.value(for: Twitch.WebRequestKeys.data)
    }
}
