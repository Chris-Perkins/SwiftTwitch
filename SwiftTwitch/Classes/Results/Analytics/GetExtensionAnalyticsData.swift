//
//  GetExtensionAnalyticsData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/28/18.
//

import Marshal

/// `GetExtensionAnalyticsData` is a class that is used to provide a robust interface for data
/// received from the `Get Extension Analytics` call of the New Twitch API.
public struct GetExtensionAnalyticsData: Unmarshaling {

    /// `reportData` holds the reports returned by the New Twitch API that contain information on
    /// the analytics reports.
    public let reportData: [ExtensionAnalyticsReportData]

    /// `paginationData` defines the token that allows for the pagination of results in the
    /// `Get Extension Analytics` call.
    public let paginationData: PaginationData?

    /// Initializes a `GetExtensionAnalyticsData` object from the input `MarshaledObject`. This will
    /// throw if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `GetExtensionAnalyticsData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        reportData = try object.value(for: Twitch.WebRequestKeys.data)
        paginationData = try? object.value(for: Twitch.WebRequestKeys.pagination)
    }
}
