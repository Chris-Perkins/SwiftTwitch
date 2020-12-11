//
//  GetUserFollowsParams.swift
//  SwiftTwitch
//
//  Created by Kevin Romero Peces-Barba on 14/07/2020.
//

import Foundation

/// `GetUserFollowsParams`
public struct GetUserFollowsParams: Codable {

    /// User ID. The request returns information about users who are being followed by the `from_id user.
    let fromId: String?
    /// User ID. The request returns information about users who are following the `to_id` user.
    let toId: String?
    /// Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. (optional)
    ///
    /// The cursor value specified here is from the pagination response field of a prior query.
    let after: String?
    /// Maximum number of objects to return.
    ///
    /// Maximum: 100.
    ///
    /// Default: 20.
    let first: Int?

}

extension GetUserFollowsParams: Codable {

    enum CodingKeys: String, CodingKey {
        case fromId = "from_id"
        case toId = "to_id"
        case after = "after"
        case first = "first"
    }
    
}
