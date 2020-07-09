//
//  UserFollowData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/31/18.
//

import Foundation

/// `UserFollowData` is a class that encapsulates a single data point of a following relationship
/// as retrieved by the `Get Users Follows` call of the New Twitch API. This includes:
/// * The user who is following (username and ID)
/// * The followed user (username and ID)
/// * The date that the relationship was established on
public struct UserFollowData: Decodable {

    /// `followStartDate` specifies the day on which the following relationship was started on.
    public let followStartDate: Date

    /// `followerId` specifies the ID of the user who is following someone in this relationship.
    public let followerId: String

    /// `followerName` specifies the name of the user who is following someone in this relationship.
    public let followerName: String

    /// `followedUserId` specifies the ID of the user who is being followed in this relationship.
    public let followedUserId: String

    /// `followedUserName` specifies the name of the user who is being followed in this
    /// relationship.
    public let followedUserName: String

}
