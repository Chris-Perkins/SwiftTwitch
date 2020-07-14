//
//  GetTopGamesData.swift
//  Marshal
//
//  Created by Christopher Perkins on 12/29/18.
//

import Foundation

/// `GetTopGamesData` is a class that is used to provide a robust interface for data received
/// from the `Get Top Games` call of the New Twitch API.
public struct GetTopGamesData: Codable {
    
    /// `gameData` specifies the data of the top games that was retrieved from the API call.
    public let gameData: [GameData]
    
    /// `paginationData` defines the token that allows for the pagination of results in the
    /// `Get Top Games` call.
    public let paginationData: PaginationData?

}
