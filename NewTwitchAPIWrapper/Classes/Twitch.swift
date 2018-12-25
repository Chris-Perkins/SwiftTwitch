//
//  Twitch.swift
//  NewTwitchAPIWrapper
//
//  Created by Christopher Perkins on 12/14/18.
//

import Foundation

/// `Twitch` allows access to all New Twitch API functions.
///
/// [The complete API reference is available here](https://dev.twitch.tv/docs/api/reference/)
public class Twitch {

    // TODO: Do not use the shared singleton as it may have its delegate set up already. This may
    // cause unexpected delegate method receivals.
    /// `urlSessionForInstance` is a singleton for all Twitch API calls that will be used for.
    private static let urlSessionForInstance: URLSession = URLSession.shared

    /// `RequestHeaderTypes` specifies the different types of headers that we'll use in our web
    /// requests
    private struct RequestHeaderTypes {
        static let post = "POST"
        static let get = "GET"
    }

    /// `getIfErrorOccurred` is a quick function used by URLTask Completion Handlers for determining
    /// if an error occurred during the web request.
    ///
    /// Errors are said to occur in four situations:
    /// 1. The data is nil
    /// 1. The error is NOT nil
    /// 1. The response is nil
    /// 1. The response status code is not 200
    ///
    /// - Parameters:
    ///   - data: The data received
    ///   - response: The response received
    ///   - error: The error received
    /// - Returns: Whether or not an error occured during the web request.
    private static func getIfErrorOccurred(data: Data?, response: URLResponse?, error: Error?) -> Bool {
        guard let response = response, data == nil || error != nil else {
            return true
        }
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            return true
        }
        return false
    }

    // MARK: - Extension Analytics

    /// Extension Analytics provides insight into the extensions that the authenticated user uses.
    /// These reports are viewable and downloadable via a URL that is returned as a response.
    ///
    /// [More information is available here](https://dev.twitch.tv/docs/insights/)
    public struct Analytics {

        /// The URL that will be used for all Extension Analytics calls.
        private static let url = URL(string: "https://api.twitch.tv/helix/analytics/extensions")!

        /// `WebRequestKeys` define the web request keys for both resolving results and sending
        /// requests for the `Get Extension Analytics` call of the New Twitch API.
        private struct WebRequestKeys {
            static let after = "after"
            static let endedAt = "ended_at"
            static let extensionId = "extension_id"
            static let first = "first"
            static let gameId = "game_id"
            static let pagination = "pagination"
            static let startedAt = "started_at"
            static let type = "type"
            static let url = "URL"
        }

        /// `type` defines the different types of extension analytics reports.
        /// `overviewVersion1` returns analytics for the first 90 days, and `overviewVersion2`
        /// returns analytics from January 31st, 2018 to the current day.
        ///
        /// These reports are viewable and downloadable via a URL that is returned as a response.
        ///
        /// [A complete comparison is available here](https://dev.twitch.tv/docs/insights/)
        ///
        /// - overviewVersion1: The first version of extension analytics reports
        /// - overviewVersion2: The second version of extension analytics reports.
        public enum AnalyticsType: String {
            case overviewVersion1 = "overview_v1"
            case overviewVersion2 = "overview_v2"
        }

        /// `GetResult` defines the different types of results that can be retrieved from the `get`
        /// call of the `Extension Analytics` API. Variables are included that specify the data that
        /// was returned.
        ///
        /// - success: Defines that the call was successful. The included variables should be input
        /// in the following order:
        /// 1. URL - Specifies the URL that Twitch returned
        /// 1. AnalyticsType - Specifies the analytics type that was returned from the API
        /// 1. Date - Specifies the start date of the analytics result
        /// 1. Date - Specifies the ending date of the analytics result
        /// 1. String - Specifies the Extension ID of the analytics result
        /// 1. String? - Specifies the pagination token; `nil` if an extension ID was used in the
        /// call
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetExtensionAnalyticsResult {
            case success(URL, AnalyticsType, Date, Date, String, String?)
            case failure(Data?, URLResponse?, Error?)
        }

        /// `get` will run the `Get Extension Analytics` API call of the New Twitch API.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/reference/#get-extension-analytics)
        ///
        /// - Parameters:
        ///   - tokenManager: The TokenManager whose token should be used. Singleton by default.
        ///   - after: The pagination token of the call. This parameter is ignored if the
        /// `extensionId` parameter is specified.
        ///   - startedAt: The date after which all analytics should start after. `endedAt` must
        /// also be specified.
        ///   - endedAt: The date before which analytics should be gathered for. `startedAt` must
        /// also be specified.
        ///   - extensionId: The extension to gather analytics for. If this is specified, only the
        /// extension with the specified ID will be analyzed.
        ///   - first: The number of objects to retrieve.
        ///   - type: The type of report to gather. For more information, please see documentation
        /// on `AnalyticsType`.
        ///   - completionHandler: The function that should be run whenever the retrieval is
        /// successful. There are two types of `GetResult`: `success` and `failure`. For more
        /// information on what values are returned, please see documentation on `GetResult`
        ///
        /// - seealso: `AnalyticsType`
        /// - seealso: `GetResult`
        public static func getExtensionAnalytics(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                                 after: String? = nil, startedAt: Date? = nil, endedAt: Date? = nil,
                                                 extensionId: String? = nil, first: Int? = nil,
                                                 type: AnalyticsType? = nil,
                                                 completionHandler: @escaping (GetExtensionAnalyticsResult) -> Void) {
            var request = URLRequest(url: url)
            do {
                try request.addTokenAuthorizationHeader(fromTokenManager: tokenManager)
            } catch {
                completionHandler(GetExtensionAnalyticsResult.failure(nil, nil, error))
                return
            }

            request.setValueToJSONContentType()
            request.httpBody =
                convertGetExtensionAnalyticsToDict(after: after, startedAt: startedAt, endedAt: endedAt,
                                                   extensionId: extensionId, first: first, type: type).getAsData()

            urlSessionForInstance.dataTask(with: request) { (data, response, error) in
                print(data == nil)
                guard !Twitch.getIfErrorOccurred(data: data, response: response, error: error) else {
                    completionHandler(GetExtensionAnalyticsResult.failure(data, response, error))
                    return
                }

                guard let nonNilData = data, let dataAsDictionary = nonNilData.getAsDictionary() else {
                    completionHandler(GetExtensionAnalyticsResult.failure(data, response, error))
                    return
                }

                guard let urlStr = dataAsDictionary[WebRequestKeys.url] as? String,
                    let url = URL(string: urlStr),
                    let extensionId = dataAsDictionary[WebRequestKeys.extensionId] as? String,
                    let reportTypeStr = dataAsDictionary[WebRequestKeys.type] as? String,
                    let reportType = getAnalyticsType(from: reportTypeStr),
                    let startedAtStr = dataAsDictionary[WebRequestKeys.startedAt] as? String,
                    let startedAtDate = Date.convertZuluDateStringToLocalDate(startedAtStr),
                    let endedAtStr = dataAsDictionary[WebRequestKeys.endedAt] as? String,
                    let endedAtDate = Date.convertZuluDateStringToLocalDate(endedAtStr) else {
                        completionHandler(
                            GetExtensionAnalyticsResult.failure(data, response, error))
                        return
                }
                let paginationToken = dataAsDictionary[WebRequestKeys.pagination] as? String
                completionHandler(
                    GetExtensionAnalyticsResult.success(url, reportType, startedAtDate, endedAtDate,
                                                        extensionId, paginationToken))
            }
        }

        /// `convertGetExtensionAnalyticsToDict` is used to convert the typed Characters into a list
        /// of web request parameters as a String-keyed Dictionary.
        ///
        /// - Parameters:
        ///   - after: input
        ///   - startedAt: input
        ///   - endedAt: input
        ///   - extensionId: input
        ///   - first: input
        ///   - type: input
        /// - Returns: The String-keyed `Dictionary` of parameters.
        private static func convertGetExtensionAnalyticsToDict(after: String?, startedAt: Date?, endedAt: Date?,
                                                               extensionId: String?, first: Int?,
                                                               type: AnalyticsType?) -> [String: Any] {
            var parametersDictionary = [String: Any]()

            if let after = after {
                parametersDictionary[WebRequestKeys.after] = after
            }
            if let startedAt = startedAt {
                parametersDictionary[WebRequestKeys.startedAt] =
                    Date.convertDateToZuluString(startedAt)
            }
            if let endedAt = endedAt {
                parametersDictionary[WebRequestKeys.endedAt] = Date.convertDateToZuluString(endedAt)
            }
            if let extensionId = extensionId {
                parametersDictionary[WebRequestKeys.extensionId] = extensionId
            }
            if let first = first {
                parametersDictionary[WebRequestKeys.first] = first
            }
            if let type = type {
                parametersDictionary[WebRequestKeys.type] = type.rawValue
            }

            return parametersDictionary
        }
        
        /// `getAnalyticsType` is used to retrieve the type of Analytics Report given its String
        /// representation.
        ///
        /// - Parameter analyticsTypeString: The analytics type string to retrieve an
        /// `AnalyticsType` for
        /// - Returns: An `AnalyticsType` corresponding to the input `String` if it exists; nil if
        /// no such relationship exists.
        private static func getAnalyticsType(from analyticsTypeString: String) -> AnalyticsType? {
            switch analyticsTypeString {
            case AnalyticsType.overviewVersion1.rawValue:
                return AnalyticsType.overviewVersion1
            case AnalyticsType.overviewVersion2.rawValue:
                return AnalyticsType.overviewVersion2
            default:
                return nil
            }
        }
    }

    /// Private initializer. The entire Twitch API can be accessed through static methods.
    private init() { }
}

// MARK: - URLRequest Extensions

extension URLRequest {
    
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

// TODO: Move Extensions to separate files

// MARK: - Dictionary Extensions

extension Dictionary where Key == String, Value == Any {

    /// Converts the `Dictionary` to its `Data` representation.
    ///
    /// - Returns: The `Data` representation of the `Dictionary`.
    internal func getAsData() -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
}

// MARK: - Data Extensions

extension Data {

    /// Gets a String-keyed `Dictionary` object from a `Data` object.
    ///
    /// - Returns: The nullable String-keyed `Dictionary` representation of the `Data`.
    internal func getAsDictionary() -> Dictionary<String, Any>? {
        return NSKeyedUnarchiver.unarchiveObject(with: self) as? Dictionary<String, Any>
    }
}

// MARK: - Date Extensions

extension Date {

    /// `zuluDateFormatter` is a lazily-instantiated date formatter whose time zone is set to UTC
    /// and whose format is RFC 3339.
    ///
    /// The RFC 3339 format is "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    private static var zuluDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")!

        return dateFormatter
    }()

    /// `convertZuluDateStringToLocalDate` takes in a RFC 3339 Date `String` from the UTC time zone
    /// and converts it to a `Date` appropriate for the current time zone.
    ///
    /// The RFC 3339 format is "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    ///
    /// - Parameter dateString: The date string to convert
    /// - Returns: The date that was converted to from the input `dateString`
    internal static func convertZuluDateStringToLocalDate(_ dateString: String) -> Date? {
        return zuluDateFormatter.date(from: dateString)
    }

    /// `convertDateToZuluString` takes in a Date and converts it to an RFC 3339 formatted String in
    /// the UTC TimeZone.
    ///
    /// The RFC 3339 format is "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    ///
    /// - Parameter date: The `Date` to convert to a Zulu time `String`
    /// - Returns:
    internal static func convertDateToZuluString(_ date: Date) -> String {
        return zuluDateFormatter.string(from: date)
    }
}
