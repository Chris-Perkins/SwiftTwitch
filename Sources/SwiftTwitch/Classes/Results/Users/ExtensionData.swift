//
//  ExtensionData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/31/18.
//

import Marshal

/// `ExtensionData` provides data regarding a single Extension on Twitch. This data can be retrieved
/// by using the `GetUserExtensions` API call. This object contains the following information:
/// * The ID of the extension
/// * The version of the extension
/// * The name of the extension
/// * Whether or not this extension is activatable
/// * The type of extension
public struct ExtensionData: Unmarshaling {

    /// `ExtensionType` is used to define the types for which an extension can be activated for.
    ///
    /// - component: Extension can be activated as a component
    /// - mobile: Extension can be activated on mobile
    /// - panel: Extension can be activated as a panel
    /// - overlay: Extension can be activated on overlay
    public enum ExtensionType: String {
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
    
    /// Initializes a `ExtensionData` object from the input `MarshaledObject`. This will throw if
    /// there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `ExtensionData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        id = try object.value(for: Twitch.WebRequestKeys.id)
        version = try object.value(for: Twitch.WebRequestKeys.version)
        name = try object.value(for: Twitch.WebRequestKeys.name)
        activatable = try object.value(for: Twitch.WebRequestKeys.canActivate)
        type = try object.value(for: Twitch.WebRequestKeys.type)
    }
}
