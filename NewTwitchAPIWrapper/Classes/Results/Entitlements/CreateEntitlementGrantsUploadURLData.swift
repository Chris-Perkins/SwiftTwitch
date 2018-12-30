//
//  CreateEntitlementGrantsUploadURLData.swift
//  Marshal
//
//  Created by Christopher Perkins on 12/29/18.
//

import Marshal

/// `CreateEntitlementGrantsUploadURLData` is a class that encapsulates data returned from a
/// `Create Entitlement Grants Upload URL` call from the New Twitch API
public struct CreateEntitlementGrantsUploadURLData: Unmarshaling {

    /// `dataPieces` defines the different data pieces that were received during this call. The
    /// expected size of this array should be 1.
    public let dataPieces: [CreateEntitlementGrantsUploadURLDataPiece]

    /// Initializes a `CreateEntitlementGrantsUploadURLDataPiece` object from the input
    /// `MarshaledObject`. This will throw if there is missing data from the input
    /// `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `CreateEntitlementGrantsUploadURLDataPiece`
    /// from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        dataPieces = try object.value(for: Twitch.WebRequestKeys.data)
    }
}
