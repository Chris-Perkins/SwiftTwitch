//
//  GameData.swift
//  Marshal
//
//  Created by Christopher Perkins on 12/29/18.
//

import Foundation

/// `GameData` is a class that encapsulates all of the information of a single returned game from
/// the returned array of Game data from the New Twitch API's `Games` methods.
public struct GameData: Codable {
    
    /// `boxArtURL` specifies the URL as a `String` where the box art of the game can be found.
    /// To use this as a real `URL`, you must replace the `%{width}` and `%{height}` strings found
    /// within the URL. Otherwise, it is not considered a valid URL.
    public let boxArtURLString: String
    
    /// `id` specifies the ID of the game on Twitch.
    public let id: String
    
    /// `name` specifies the name of the game on Twitch.
    public let name: String

}
