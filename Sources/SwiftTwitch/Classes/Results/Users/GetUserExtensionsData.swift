//
//  GetUserExtensionsData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/31/18.
//

import Foundation

/// `GetUserExtensionsData` is a class that encapsulates all of the information returned by the
/// `Get User Extensions` call of the New Twitch API. This includes:
/// * The extensions data for the token-bearing user
public struct GetUserExtensionsData: Codable {

    /// `extensionsData` contains the data of the extensions that were retrieved from a
    /// `Get User Extensions` API call.
    public let extensionsData: [ExtensionData]

}
