//
//  PaginationData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Marshal

/// `PaginationData` is used to contain data about Pagination in API calls whose responses are too
/// large to fit within a single response.
public struct PaginationData: Unmarshaling {

    /// The token that should be used for Pagination.
    public let token: String

    /// Initializes a `PaginationData` object from the input `MarshaledObject`. This will throw if
    /// there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `PaginationData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        token = try object.value(for: Twitch.WebRequestKeys.cursor)
    }
}
