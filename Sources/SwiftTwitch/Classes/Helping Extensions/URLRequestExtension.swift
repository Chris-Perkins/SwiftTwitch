//
//  URLRequestExtension.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/28/18.
//

import Foundation

extension URLRequest {
    
    /// `RequestHeaderTypes` specifies the different types of headers that are used in Web Requests.
    /// This enum will be expanded if additional request types are required.
    internal struct RequestHeaderTypes {
        static let get = "GET"
        static let post = "POST"
        static let put = "PUT"
    }
    
    /// `AuthorizationError` is used to specify the types of `Error`s that may occur while
    /// attempting to add an authorization token to a URLRequest.
    ///
    /// - nilAccessToken: Used to specify that the access token was unexpectedly nil
    internal enum AuthorizationError: Error {
        case nilAccessToken
        case nilClientID
    }
    
    /// The application JSON value.
    private static let applicationJSONValue = "application/json"
    
    /// The Content-Type string key.
    private static let contentTypeString = "Content-Type"
    
    /// The Authorization Header specifier.
    private static let authorizationHeader = "Authorization"

    /// The Client ID header specifier.
    private static let clientIDHeaderPrefix = "Client-ID"
    
    /// The prefix of Authorization headers.
    ///
    /// This value is in the format of "$PREFIX $VALUE".
    private static let authorizationValueBearerHeaderPrefix = "Bearer"
    

    
    /// The prefix of OAuth headers.
    ///
    /// This value is in the format of "$PREFIX $VALUE". (v5)
    private static let authorizationValueOAuthHeaderPrefix = "OAuth"
    
    /// The accept header specifier. (v5)
    private static let accept = "accept"
    
    /// The prefix of v5 accept headers. (v5)
    private static let twitchVersion5AcceptString = "application/vnd.twitchtv.v5+json"
    
    /// Sets the Content-Type of this URLRequest to use application/json.
    internal mutating func setValueToJSONContentType() {
        setValue(URLRequest.applicationJSONValue, forHTTPHeaderField: URLRequest.contentTypeString)
    }
    
    /// `addTokenAuthorizationHeader` is used to add an Authorization header to a `URLRequest` whose
    /// recipient is meant for the New Twitch API. This function will use the provided
    /// `TwitchTokenManager` to set the token and clientID value.
    ///
    /// - Parameter tokenManager: The `TwitchTokenManager` whose token and client ID should be used as
    /// authorization
    internal mutating func addTokenAuthorizationHeader(fromTokenManager tokenManager: TwitchTokenManager) throws {
        guard let token = tokenManager.accessToken else {
            throw AuthorizationError.nilAccessToken
        }
        guard let clientID = tokenManager.clientID else {
            throw AuthorizationError.nilClientID
        }

        setValue("\(URLRequest.authorizationValueBearerHeaderPrefix) \(token)",
            forHTTPHeaderField: URLRequest.authorizationHeader)
        setValue(clientID,
            forHTTPHeaderField: URLRequest.clientIDHeaderPrefix)
    }
    
    /// `addOAuthAuthorizationHeader` is used to add an Authorization OAuth to a `URLRequest` whose
    /// recipient is meant for the v5 Twitch API. This function will use the provided
    /// `TwitchTokenManager` to set the token value and will also request the version 5 of the
    /// kraken API.
    ///
    /// - Parameter tokenManager: The `TwitchTokenManager` whose token should be used as
    /// authorization
    internal mutating func addOAuthAuthorizationHeader(fromTokenManager tokenManager: TwitchTokenManager) throws {
        guard let token = tokenManager.accessToken else {
            throw AuthorizationError.nilAccessToken
        }
        setValue("\(URLRequest.authorizationValueOAuthHeaderPrefix) \(token)",
            forHTTPHeaderField: URLRequest.authorizationHeader)
        setValue(URLRequest.twitchVersion5AcceptString,
            forHTTPHeaderField: URLRequest.accept)
    }
}
