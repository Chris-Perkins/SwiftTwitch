//
//  UpdateUserParams.swift
//  SwiftTwitch
//
//  Created by Kevin Romero Peces-Barba on 14/07/2020.
//

import Foundation

/// `UpdateUserParams`
public struct UpdateUserParams {

    /// User’s account description. (optional)
    let description: String?

}

extension UpdateUserParams: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
    }

}
