//
//  UserData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `UserData` is a class that encapsulates all of the information of a single user on Twitch.
public struct UserData: Decodable {

    /// `UserType` is used to show the role that a user has on Twitch.tv.
    ///
    /// - staff: The user is a staff member of Twitch
    /// - admin: The user is an administrator of Twitch
    /// - globalMod: The user is a moderator on all channels of Twitch
    /// - normal: The user is a normal user.
    public enum UserType: String, Decodable {
        case staff = "staff"
        case admin = "admin"
        case globalMod = "global_mod"
        case normal = ""
    }

    /// `BroadcasterType` is used to show the type of streamer that a user is. For more information
    /// on the differences between a partner, affiliate, and a normal streamer, please visit
    /// [here](https://help.twitch.tv/customer/portal/articles/2785927-joining-the-affiliate-program)
    ///
    ///
    /// - partner: The user is a partner on Twitch; special features are available for this user.
    /// - affiliate: The user is an affiliate on Twitch; monetization on streams is possible.
    /// - normal: The user is a normal streamer on Twitch; no special permissions are garnered.
    public enum BroadcasterType: String, Decodable {
        case partner = "partner"
        case affiliate = "affiliate"
        case normal = ""
    }

    /// `userId` specifies the ID of the user.
    public let userId: String

    /// `userLoginName` specifies the login name of the user.
    public let userLoginName: String

    /// `userDisplayName` specifies the display name of the user.
    public let userDisplayName: String

    /// `userType` specifies the type of user that this user is.
    public let userType: UserType

    /// `broadcasterType` specifies the type of broadcaster that this user is.
    public let broadcasterType: BroadcasterType

    /// `description` specifies the description this user has.
    public let description: String?

    /// `profileImageURL` specifies the url of the profile image for this user.
    public let profileImageURL: URL

    /// `offlineImageURL` specifies the offline image url of this user. This image is shown whenever
    /// their stream is visited, but it is offline.
    public let offlineImageURL: URL?

    /// `viewCount` specifies the number of views that this user has.
    public let viewCount: Int

    /// `email` specifies the email that this user has. This variable will only be returned if the
    /// `Get User(s)` API was called on one's self and `user:read:email` is defined as a scope of
    /// permissions for the token provided.
    public let email: String?

}
