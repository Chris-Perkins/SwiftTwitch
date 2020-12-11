//
//  GetTopGamesParams.swift
//  SwiftTwitch
//
//  Created by Kevin Romero Peces-Barba on 18/07/2020.
//

import Foundation

/// `GetTopGamesParams`
public struct GetTopGamesParams {

    /// Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. (optional)
    ///
    /// The cursor value specified here is from the pagination response field of a prior query.
    let after: String?
    /// Cursor for backward pagination: tells the server where to start fetching the next set of results, in a multi-page response. (optional)
    ///
    /// The cursor value specified here is from the pagination response field of a prior query.
    let before: String?
    /// Maximum number of objects to return. (optional)
    ///
    /// Maximum: 100.
    ///
    /// Default: 20.
    let first: Int?

}

extension GetTopGamesParams: Codable {

    enum CodingKeys: String, CodingKeys {
        case after = "after"
        case before = "before"
        case first = "first"
    }

}
