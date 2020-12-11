//
//  GetUsersParams.swift
//  SwiftTwitch
//
//  Created by Kevin Romero Peces-Barba on 14/07/2020.
//

import Foundation

/// `GetUsersParams`
public struct GetUsersParams {

    /// User ID. (optional)
    ///
    /// Multiple user IDs can be specified.
    ///
    /// Limit: 100.
    ///
    /// A request can include a mixture of login names and user ID
    ///
    /// The limit of 100 IDs and login names is the total limit. You can request, for example, 50 of each or 100 of one of them. You cannot request 100 of both.
    let userIds: [String]?
    /// User login name. (optional)
    ///
    /// Multiple login names can be specified.
    ///
    /// Limit: 100.
    ///
    /// A request can include a mixture of login names and user ID
    ///
    /// The limit of 100 IDs and login names is the total limit. You can request, for example, 50 of each or 100 of one of them. You cannot request 100 of both.
    let logins: [String]?

}

extension GetUsersParams: Codable {

    enum CodingKeys: String, CodingKey {
        case userIds = "user_id"
        case logins = "login"
    }

}
