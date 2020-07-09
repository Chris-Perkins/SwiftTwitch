//
//  GetStreamsMetadataData.swift
//  Marshal
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `GetStreamsMetadataData` is a class that is used to provide a robust interface for data received
/// from the `Get Streams` call of the New Twitch API.
public struct GetStreamsMetadataData: Decodable {
    
    /// `streamMetadata` specifies the metadata of the streams that was retrieved from the API call.
    public let streamMetadata: [StreamMetadata]
    
    /// `paginationData` defines the token that allows for the pagination of results in the
    /// `Get Streams Metadata` call.
    public let paginationData: PaginationData?

}
