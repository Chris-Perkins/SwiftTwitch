//
//  GetExtensionAnalyticsParams.swift
//  SwiftTwitch
//
//  Created by Kevin Romero Peces-Barba on 18/07/2020.
//

import Foundation

/// `GetExtensionAnalyticsParams`
public struct GetExtensionAnalyticsParams {

    /// Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. (optional)
    ///
    /// This applies only to queries without `extension_id`. If an `extension_id` is specified, it supersedes any cursor/offset combinations. The cursor value specified here is from the pagination response field of a prior query.
    let after: String?
    /// Ending date/time for returned reports, in RFC3339 format with the hours, minutes, and seconds zeroed out and the UTC timezone. (optional)
    ///
    /// If this is provided, `started_at` also must be specified. If `ended_at is later than the default end date, the default date is used. Default: 1-2 days before the request was issued (depending on report availability).
    let endedAt: Date?
    /// Client ID value assigned to the extension when it is created. (optional)
    ///
    /// If this is specified, the returned URL points to an analytics report for just the specified extension.
    ///
    /// If this is not specified, the response includes multiple URLs (paginated), pointing to separate analytics reports for each of the authenticated user’s extensions.
    let extensionId: String?
    /// Maximum number of objects to return. (optional)
    ///
    /// Maximum: 100.
    ///
    /// Default: 20.
    let first: Int?
    /// Starting date/time for returned reports, in RFC3339 format with the hours, minutes, and seconds zeroed out and the UTC timezone. (optional)
    ///
    /// If this is provided, `ended_at` also must be specified. If `started_at` is earlier than the default start date, the default date is used. Default: January 31, 2018 (overview_v2) or 90 days (overview_v1) before the report was issued. The file contains one row of data per day.
    let startedAt: Date?
    /// Type of analytics report that is returned. (optional)
    ///
    /// If this is specified, the response includes one URL, for the specified report type.
    ///
    /// If this is not specified, the response includes multiple URLs (paginated), one for each report type available for the authenticated user’s Extensions.
    ///
    /// Limit: 1.
    ///
    /// Valid values: `.overviewVersion1`, `.overviewVersion2`.
    ///
    /// Default: all report types for the authenticated user’s Extensions.
    let reportType: Twitch.Analytics.AnalyticsType?

}

extension GetExtensionAnalyticsParams: Codable {

    enum CodingKeys: String, CodingKey {
        case after = "after"
        case endedAt = "ended_at"
        case extensionId = "extension_id"
        case first = "first"
        case startedAt = "started_at"
        case reportType = "type"
    }

}
