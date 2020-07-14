//
//  UpdateUserData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/31/18.
//

import Marshal

/// `UpdateUserData` is a class that encapsulates all of the information returned by the
/// `Update User` call of the New Twitch API. This includes:
/// * The data of the user that was updated
public struct UpdateUserData: Unmarshaling {
    
    /// `userData` contains the data of the users that were retrieved from a `Update User` API call.
    public let userData: [UserData]
    
    /// Initializes a `UpdateUserData` object from the input `MarshaledObject`. This will throw if
    /// there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `UpdateUserData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        userData = try object.value(for: Twitch.WebRequestKeys.data)
    }
}

