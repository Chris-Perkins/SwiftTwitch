//
//  CreateClipInfoData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/29/18.
//

import Foundation

/// `CreateClipInfoData` is a class that encapsulates all of the information of a single returned
/// clip from the returned array of Clip data from the New Twitch API's `Create Clip` call.
public struct CreateClipInfoData: Decodable {

    /// `editURL` specifies the URL of the clip that was created. This URL can be used to edit the
    /// clip.
    public let editURL: URL

    /// `id` specifies the ID of the clip that was created.
    public let id: String

}

