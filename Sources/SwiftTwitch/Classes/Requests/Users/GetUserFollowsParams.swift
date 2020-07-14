//
//  GetUserFollowsParams.swift
//  
//
//  Created by Kevin Romero Peces-Barba on 14/07/2020.
//

import Foundation

/// `GetUserFollowsParams`
public struct GetUserFollowsParams: Codable {

    /// fromId: The ID of the follower. Use this to get users this user is following.
    let fromId: String?

    /// toId: The ID of the user being followed. Use this to get the users that are
    /// following this user.
    let toId: String?

    /// after: The forward pagination token.
    let after: String?

    /// first: The number of results to return. Default 20. Maximum 100.
    let first: Int?

}
