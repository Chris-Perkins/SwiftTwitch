//
//  ExtensionData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/31/18.
//

import Foundation

/// `ExtensionData` provides data regarding a single Extension on Twitch. This data can be retrieved
/// by using the `GetUserExtensions` API call. This object contains the following information:
/// * The ID of the extension
/// * The version of the extension
/// * The name of the extension
/// * Whether or not this extension is activatable
/// * The type of extension
public struct ExtensionData: Decodable {

    /// `ExtensionType` is used to define the types for which an extension can be activated for.
    ///
    /// - component: Extension can be activated as a component
    /// - mobile: Extension can be activated on mobile
    /// - panel: Extension can be activated as a panel
    /// - overlay: Extension can be activated on overlay
    public enum ExtensionType: String, Decodable {
        case component = "component"
        case mobile = "mobile"
        case panel = "panel"
        case overlay = "overlay"
    }

    /// `id` specifies the ID of the extension.
    public let id: String

    /// `version` specifies the version of the extension.
    public let version: String

    /// `name` specifies the name of the extension.
    public let name: String

    /// `activatable` specifies whether or not this extension can be activated.
    public let activatable: Bool

    /// `type` specifies the type of this extension. This is made up of 0 or more `ExtensionType`s.
    ///
    /// - seeAlso: `ExtensionType`
    public let type: [ExtensionType]

}
