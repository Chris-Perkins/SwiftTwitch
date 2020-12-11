//
//  GetStreamsData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `GetStreamsData` is a class that is used to provide a robust interface for data received
/// from the `Get Streams` call of the New Twitch API.
public struct GetStreamsData: Codable {

    /// `streamData` specifies the data of the streams that was retrieved from the API call.
    public let streamData: [StreamData]

    /// `paginationData` defines the token that allows for the pagination of results in the
    /// `Get Streams` call.
    public let paginationData: PaginationData?

}
