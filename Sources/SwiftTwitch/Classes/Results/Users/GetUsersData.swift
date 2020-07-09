//
//  GetUsersData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `GetUsersData` is a class that encapsulates all of the information returned by the `Get Users`
/// call of the New Twitch API. This includes:
/// * The data of the user that was updated
public struct GetUsersData: Decodable {
    
    /// `userData` contains the data of the users that were retrieved from a `Get Users` API call.
    public let userData: [UserData]

}
