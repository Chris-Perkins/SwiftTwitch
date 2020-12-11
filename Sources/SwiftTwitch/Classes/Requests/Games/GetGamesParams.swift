//
//  GetGamesParams.swift
//  SwiftTwitch
//
//  Created by Kevin Romero Peces-Barba on 18/07/2020.
//

import Foundation

/// `GetGamesParams`
public struct GetGamesParams {

    /// Game ID.
    ///
    /// At most 100 id values can be specified.
    ///
    /// For a query to be valid, `name` and/or `id` must be specified.
    let gameIds: [String]?
    /// Game name.
    ///
    /// The name must be an exact match. For instance, “Pokemon” will not return a list of Pokemon games; instead, query the specific Pokemon game(s) in which you are interested.
    ///
    /// At most 100 name values can be specified.
    ///
    /// For a query to be valid, `name` and/or `id` must be specified.
    let name: String?

}

extension GetGamesParams: Codable {

    enum CodingKeys: String, CodingKeys {
        case gameIds = "id"
        case name = "name"
    }

}
