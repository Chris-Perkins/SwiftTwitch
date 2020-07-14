//
//  GetVideosResult.swift
//  Marshal
//
//  Created by Christopher Perkins on 1/1/19.
//

import Foundation

/// `GetVideosData` is a class that encapsulates all of the information of a single returned clip
/// from the returned array of Clip data from the New Twitch API's `Get Videos` call.
public struct GetVideosData: Codable {

    /// `clipData` specifies the data of the Videos that was retrieved from the API call.
    public let videoData: [VideoData]

    /// `paginationData` defines the token that allows for the pagination of results in the
    /// `Get Videos` call.
    public let paginationData: PaginationData?

}
