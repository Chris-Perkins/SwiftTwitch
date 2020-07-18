//
//  CreateStreamMarkerParams.swift
//  SwiftTwitch
//
//  Created by Kevin Romero Peces-Barba on 18/07/2020.
//

import Foundation

/// `CreateStreamMarkerParams`
public struct CreateStreamMarkerParams {

    /// ID of the broadcaster in whose live stream the marker is created. (required)
    let userId: String
    /// Description of or comments on the marker. Max length is 140 characters. (optional)
    let description: String?

}

extension CreateStreamMarkerParams: Codable {

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case description = "description"
    }

}
