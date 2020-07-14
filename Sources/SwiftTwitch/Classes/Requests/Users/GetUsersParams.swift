//
//  GetUsersParams.swift
//  
//
//  Created by Kevin Romero Peces-Barba on 14/07/2020.
//

import Foundation

/// `GetUsersParams`
public struct GetUsersParams: Codable {

    /// id: The IDs of the users to look up information for
    let id: [String]?

    /// login: The login names of the users to look up information for
    let login: [String]?

}
