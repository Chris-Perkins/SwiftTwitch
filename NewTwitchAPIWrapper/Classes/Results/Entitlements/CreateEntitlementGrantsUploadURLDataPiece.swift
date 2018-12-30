//
//  CreateEntitlementGrantsUploadURLDataPiece.swift
//  Marshal
//
//  Created by Christopher Perkins on 12/29/18.
//

import Marshal

/// `CreateEntitlementGrantsUploadURLData` is a class that encapsulates data returned from a
/// `Create Entitlement Grants Upload URL` call from the New Twitch API
public struct CreateEntitlementGrantsUploadURLDataPiece: Unmarshaling {
    
    /// `url` specifies the URL where the manifest file should be uploaded. This link is valid for
    /// 15 minutes after the call is completed.
    public let url: URL
    
    /// Initializes a `CreateEntitlementGrantsUploadURLDataPiece` object from the input
    /// `MarshaledObject`. This will throw if there is missing data from the input
    /// `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `CreateEntitlementGrantsUploadURLData` piece
    /// from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        url = try object.value(for: Twitch.WebRequestKeys.url)
    }
}
