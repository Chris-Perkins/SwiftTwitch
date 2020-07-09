//
//  CreateClipData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/29/18.
//

import Foundation

/// `CreateClipData` is a class that is used to provide a robust interface for data received
/// from the `Create Clip` call of the New Twitch API. This object only has one property;
/// `clipsInfo`.
public struct CreateClipData: Decodable {

    /// `clipsInfo` specifies the received data from `Create Clip` API calls. This will contain the
    /// actual clip information from the post response.
    public let clipsInfo: [GetBitsLeaderboardUserData]

}
