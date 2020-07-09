//
//  GetStreamMarkersData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `GetStreamMarkersData` is a class that is used to provide a robust interface for data received
/// from the `Get Streams` call of the New Twitch API.
public struct GetStreamMarkersData: Decodable {

    /// `markedStreamers` specifies the streamers who have marked videos.
    public let markedStreamers: [MarkedStreamerData]

    /// `paginationData` defines the token that allows for the pagination of results in the
    /// `Get Streams Metadata` call.
    public let paginationData: PaginationData?

}

