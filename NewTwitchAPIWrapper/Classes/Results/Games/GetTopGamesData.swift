//
//  GetTopGamesData.swift
//  Marshal
//
//  Created by Christopher Perkins on 12/29/18.
//

import Marshal

/// `GetTopGamesData` is a class that is used to provide a robust interface for data received
/// from the `Get Top Games` call of the New Twitch API.
public struct GetTopGamesData: Unmarshaling {
    
    /// `gameData` specifies the data of the top games that was retrieved from the API call.
    public let gameData: [GameData]
    
    /// `paginationToken` defines the token that allows for the pagination of results in the
    /// `Get Top Games` API call.
    public let paginationToken: String?
    
    /// Initializes a `GetTopGamesData` object from the input `MarshaledObject`. This will throw
    /// if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `GetTopGamesData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        gameData = try object.value(for: Twitch.WebRequestKeys.data)
        paginationToken = try? object.value(for: Twitch.WebRequestKeys.pagination)
    }
}
