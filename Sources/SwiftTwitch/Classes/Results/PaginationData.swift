//
//  PaginationData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `PaginationData` is used to contain data about Pagination in API calls whose responses are too
/// large to fit within a single response.
public struct PaginationData: Codable {

    /// The token that should be used for Pagination.
    public let token: String

}
