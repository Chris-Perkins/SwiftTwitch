//
//  GetClipsData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/29/18.
//

import Foundation

/// `GetClipsData` is a class that encapsulates all of the information of a single returned clip
/// from the returned array of Clip data from the New Twitch API's `Get Clips` call.
public struct GetClipsData: Decodable {

    /// `clipData` specifies the data of the clips that was retrieved from the API call.
    public let clipData: [ClipData]

    /// `paginationData` defines the token that allows for the pagination of results in the
    /// `Get Clips` call.
    public let paginationData: PaginationData?

}
