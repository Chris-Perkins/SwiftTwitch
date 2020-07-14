//
//  UpdateUserData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/31/18.
//

import Foundation

/// `UpdateUserData` is a class that encapsulates all of the information returned by the
/// `Update User` call of the New Twitch API. This includes:
/// * The data of the user that was updated
public struct UpdateUserData: Codable {
    
    /// `userData` contains the data of the users that were retrieved from a `Update User` API call.
    public let userData: [UserData]

}

