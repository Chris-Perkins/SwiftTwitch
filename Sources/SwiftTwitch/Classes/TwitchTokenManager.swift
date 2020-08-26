//
//  TwitchTokenManager.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/13/18.
//

import Foundation

/// `TwitchTokenManager` is a class that is used to carry "New Twitch API" tokens.
///
/// If you wish to use a single token to pass between all API calls without having to keep reference
/// to it, then simply set up the singleton TwitchTokenManager.
///
/// The singleton instance can be retrieved by using the following syntax:
/// `TwitchTokenManager.shared`
public class TwitchTokenManager {

    // MARK: - Singleton Creator

    /// `shared` is the entry point for the singleton instance of the TwitchTokenManager.
    public static var shared: TwitchTokenManager = {
        return TwitchTokenManager()
    }()

    // MARK: - Instance-Level Properties

    /// `accessToken` should specify the access token of the New Twitch API.
    public var accessToken: String? = nil

    /// `clientID` should specify the client ID of the Twitch dev application that `accessToken` was created using.
    public var clientID: String? = nil

    /// Initializes a TwitchTokenManager.
    public init() { }
}
