//
//  GetUserExtensionsData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/31/18.
//

import Marshal

/// `GetUserExtensionsData` is a class that encapsulates all of the information returned by the
/// `Get User Extensions` call of the New Twitch API. This includes:
/// * The extensions data for the token-bearing user
public struct GetUserExtensionsData: Unmarshaling {

    /// `extensionsData` contains the data of the extensions that were retrieved from a
    /// `Get User Extensions` API call.
    public let extensionsData: [ExtensionData]

    /// Initializes a `GetUserExtensionsData` object from the input `MarshaledObject`. This will
    /// throw if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `GetUserExtensionsData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        extensionsData = try object.value(for: Twitch.WebRequestKeys.data)
    }
}
