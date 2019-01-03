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
    }
    
    /// The application JSON value.
    private static let applicationJSONValue = "application/json"
    
    /// The Content-Type string key.
    private static let contentTypeString = "Content-Type"
    
    /// The Authorization Header specifier.
    private static let authorizationHeader = "Authorization"
    
    /// The prefix of Authorization headers.
    ///
    /// This value is in the format of "$PREFIX $VALUE".
    private static let authorizationValueBearerHeaderPrefix = "Bearer"
    
    /// Sets the Content-Type of this URLRequest to use application/json.
    internal mutating func setValueToJSONContentType() {
        setValue(URLRequest.applicationJSONValue, forHTTPHeaderField: URLRequest.contentTypeString)
    }
    
    /// `addTokenAuthorizationHeader` is used to add an Authorization header to a `URLRequest` whose
    /// recipient is meant for the New Twitch API. This function will use the provided
    /// `TwitchTokenManager` to set the token value.
    ///
    /// - Parameter tokenManager: The `TwitchTokenManager` whose token should be used as
    /// authorization
    internal mutating func addTokenAuthorizationHeader(fromTokenManager tokenManager: TwitchTokenManager) throws {
        guard let token = tokenManager.accessToken else {
            throw AuthorizationError.nilAccessToken
        }
        setValue("\(URLRequest.authorizationValueBearerHeaderPrefix) \(token)",
            forHTTPHeaderField: URLRequest.authorizationHeader)
    }
}
