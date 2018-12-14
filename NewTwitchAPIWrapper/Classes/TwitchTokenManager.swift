//
//  TwitchTokenManager.swift
//  NewTwitchAPIWrapper
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
class TwitchTokenManager {

    /// `shared` is the entry point for the singleton instance of the TwitchTokenManager.
    public static var shared: TwitchTokenManager {
        if let manager = singleInstance {
            return manager
        }

        singleInstance = TwitchTokenManager()
        return singleInstance!
    }

    /// `singleInstance` holds the singleton instance that should be returned by `shared`.
    private static var singleInstance: TwitchTokenManager?

    // TODO: This maybe should require parameters?
    /// Initializes a TwitchTokenManager.
    public init() {
    }
}
