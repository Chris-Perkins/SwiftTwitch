//
//  GetStreamsMetadataParams.swift
//  SwiftTwitch
//
//  Created by Kevin Romero Peces-Barba on 18/07/2020.
//

import Foundation

/// `GetStreamsMetadataParams`
public struct GetStreamsMetadataParams {

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
    /// Returns streams broadcasting a specified game ID. (optional)
    ///
    /// You can specify up to 100 IDs.
    let gameIds: [String]?
    /// Stream language. (optional)
    ///
    /// You can specify up to 100 languages.
    let languages: [String]?
    /// Returns streams broadcast by one or more specified user IDs. (optional)
    ///
    /// You can specify up to 100 IDs.
    let userIds: [String]?
    /// Returns streams broadcast by one or more specified user login names. (optional)
    ///
    /// You can specify up to 100 names.
    let userLogins: [String]?

}

extension GetStreamsMetadataParams: Codable {

    enum CodingKeys: String, CodingKey {
        case after = "after"
        case before = "before"
        case first = "first"
        case gameIds = "game_id"
        case languages = "language"
        case userIds = "user_id"
        case userLogins = "user_login"
    }

}
