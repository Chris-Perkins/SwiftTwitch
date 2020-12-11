//
//  GetGamesData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/29/18.
//

import Foundation

/// `GetGamesData` is a class that is used to provide a robust interface for data received from the
/// `Get Games` call of the New Twitch API.
public struct GetGamesData: Codable {

    /// `gameData` specifies the data of the games that was retrieved from the API call.
    public let gameData: [GameData]

}
