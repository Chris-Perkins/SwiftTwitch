//
//  GetGamesData.swift
//  Marshal
//
//  Created by Christopher Perkins on 12/29/18.
//

import Marshal

/// `GetGamesData` is a class that is used to provide a robust interface for data received from the
/// `Get Games` call of the New Twitch API.
public struct GetGamesData: Unmarshaling {

    /// `gameData` specifies the data of the games that was retrieved from the API call.
    public let gameData: [GameData]

    /// Initializes a `GetGamesData` object from the input `MarshaledObject`. This will throw
    /// if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `GetGamesData` piece from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        gameData = try object.value(for: Twitch.WebRequestKeys.data)
    }
}
