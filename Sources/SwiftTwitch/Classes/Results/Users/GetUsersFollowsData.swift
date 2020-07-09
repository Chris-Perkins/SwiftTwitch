//
//  GetUsersFollowsData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/31/18.
//

import Foundation

/// `GetUsersFollowsData` is a class that encapsulates all of the information returned by the
/// `Get Users Follows` call of the New Twitch API. This includes:
/// * The `Following` data
/// * The number of follows or followers the user has
/// * A pagination token for use in retrieving the next/previous batch of `Get Users Follows` data
public struct GetUsersFollowsData: Decodable {

    /// `total` specifies the total number of followers or number of streams being followed by the
    /// user that the `Get Users Follows` call was made for.
    public let total: Int

    /// `followData` contains the data of following relationships that were retrieved.
    public let followData: [UserFollowData]

    /// `paginationData` defines the data that allows for the pagination of results in the
    /// `Get Users Follows` call.
    public let paginationData: PaginationData?

}
