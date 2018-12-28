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
    /// `urlSessionForWrapper` is a singleton for all Twitch API calls that will be used for.
    private static let urlSessionForWrapper: URLSession = URLSession.shared
    
    /// `WebRequestKeys` define the web request keys for both resolving results and sending requests
    /// for the New Twitch API.
    internal struct WebRequestKeys {
        static let after = "after"
        static let count = "count"
        static let endedAt = "ended_at"
        static let extensionId = "extension_id"
        static let first = "first"
        static let gameId = "game_id"
        static let pagination = "pagination"
        static let period = "period"
        static let rank = "rank"
        static let score = "score"
        static let startedAt = "started_at"
        static let total = "total"
        static let type = "type"
        static let url = "URL"
        static let userId = "user_id"
        static let userName = "user_name"
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

    // MARK: - Analytics

    /// Analytics is a category of Twitch API calls that provide insight to the game usage or
    /// extension usage of the token bearing user.
    public struct Analytics {

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

        // TODO: Change to an object with variables
        /// `GetExtensionAnalyticsResult` defines the different types of results that can be
        /// retrieved from the `getExtensionAnalytics` call of the `Analytics` API. Variables are
        /// included that specify the data that was returned.
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

        // TODO: Change to an object with variables
        /// `GetGameAnalyticsResult` defines the different types of results that can be retrieved
        /// from the `getGameAnalytics` call of the `Analytics` API. Variables are included that
        /// specify the data that was returned.
        ///
        /// - success: Defines that the call was successful. The included variables should be input
        /// in the following order:
        /// 1. URL - Specifies the URL that Twitch returned
        /// 1. AnalyticsType - Specifies the analytics type that was returned from the API
        /// 1. Date - Specifies the start date of the analytics result
        /// 1. Date - Specifies the ending date of the analytics result
        /// 1. String - Specifies the Game ID of the analytics result
        /// 1. String? - Specifies the pagination token; `nil` if an extension ID was used in the
        /// call
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetGameAnalyticsResult {
            case success(URL, AnalyticsType, Date, Date, String, String?)
            case failure(Data?, URLResponse?, Error?)
        }

        /// The URL that will be used for all Extension Analytics calls.
        private static let extensionAnalyticsURL =
            URL(string: "https://api.twitch.tv/helix/analytics/extensions")!

        /// The URL that will be used for all Game Analytics calls.
        private static let gameAnalyticsURL =
            URL(string: "https://api.twitch.tv/helix/analytics/games")!

        /// `getExtensionAnalytics` will run the `Get Extension Analytics` API call of the New
        /// Twitch API.
        ///
        /// This API call requires a token with `analytics:read:extensions` permissions.
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
        /// successful. There are two types of `GetExtensionAnalyticsResult`: `success` and
        /// `failure`. For more information on what values are returned, please see documentation on
        /// `GetExtensionAnalyticsResult`
        ///
        /// - seealso: `AnalyticsType`
        /// - seealso: `GetExtensionAnalyticsResult`
        public static func getExtensionAnalytics(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                                 after: String? = nil, startedAt: Date? = nil, endedAt: Date? = nil,
                                                 extensionId: String? = nil, first: Int? = nil,
                                                 type: AnalyticsType? = nil,
                                                 completionHandler: @escaping (GetExtensionAnalyticsResult) -> Void) {
            var request = URLRequest(url: extensionAnalyticsURL)
            do {
                try request.addTokenAuthorizationHeader(fromTokenManager: tokenManager)
            } catch {
                completionHandler(GetExtensionAnalyticsResult.failure(nil, nil, error))
                return
            }

            request.setValueToJSONContentType()
            request.httpMethod = URLRequest.RequestHeaderTypes.get
            request.httpBody =
                convertGetExtensionAnalyticsParamsToDict(after: after, startedAt: startedAt, endedAt: endedAt,
                                                         extensionId: extensionId, first: first, type: type).getAsData()

            urlSessionForWrapper.dataTask(with: request) { (data, response, error) in
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
                        completionHandler(GetExtensionAnalyticsResult.failure(data, response, error))
                        return
                }
                let paginationToken = dataAsDictionary[WebRequestKeys.pagination] as? String
                completionHandler(
                    GetExtensionAnalyticsResult.success(url, reportType, startedAtDate, endedAtDate,
                                                        extensionId, paginationToken))
            }.resume()
        }

        /// `getGameAnalytics` will run the `Get Game Analytics` API call of the New
        /// Twitch API.
        ///
        /// This API call requires a token with `analytics:read:games` permissions.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/reference/#get-game-analytics)
        ///
        /// - Parameters:
        ///   - tokenManager: The TokenManager whose token should be used. Singleton by default.
        ///   - after: The pagination token of the call. This parameter is ignored if the
        /// `gameId` parameter is specified.
        ///   - startedAt: The date after which all analytics should start after. `endedAt` must
        /// also be specified.
        ///   - endedAt: The date before which analytics should be gathered for. `startedAt` must
        /// also be specified.
        ///   - gameId: The extension to gather analytics for. If this is specified, only the
        /// game with the specified ID will be analyzed.
        ///   - first: The number of objects to retrieve.
        ///   - type: The type of report to gather. For more information, please see documentation
        /// on `AnalyticsType`.
        ///   - completionHandler: The function that should be run whenever the retrieval is
        /// successful. There are two types of `GetGameAnalyticsResult`: `success` and `failure`.
        /// For more information on what values are returned, please see documentation on
        /// `GetGameAnalyticsResult`
        ///
        /// - seealso: `AnalyticsType`
        /// - seealso: `GetGameAnalyticsResult`
        public static func getGameAnalytics(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                            after: String? = nil, startedAt: Date? = nil, endedAt: Date? = nil,
                                            gameId: String? = nil, first: Int? = nil, type: AnalyticsType? = nil,
                                            completionHandler: @escaping (GetGameAnalyticsResult) -> Void) {
            var request = URLRequest(url: gameAnalyticsURL)
            do {
                try request.addTokenAuthorizationHeader(fromTokenManager: tokenManager)
            } catch {
                completionHandler(GetGameAnalyticsResult.failure(nil, nil, error))
                return
            }

            request.setValueToJSONContentType()
            request.httpMethod = URLRequest.RequestHeaderTypes.get
            request.httpBody =
                convertGameAnalyticsParamsToDict(after: after, startedAt: startedAt, endedAt: endedAt,
                                                gameId: gameId, first: first, type: type).getAsData()

            urlSessionForWrapper.dataTask(with: request) { (data, response, error) in
                guard !Twitch.getIfErrorOccurred(data: data, response: response, error: error) else {
                    completionHandler(GetGameAnalyticsResult.failure(data, response, error))
                    return
                }

                guard let nonNilData = data, let dataAsDictionary = nonNilData.getAsDictionary() else {
                    completionHandler(GetGameAnalyticsResult.failure(data, response, error))
                    return
                }

                guard let urlStr = dataAsDictionary[WebRequestKeys.url] as? String,
                    let url = URL(string: urlStr),
                    let gameId = dataAsDictionary[WebRequestKeys.gameId] as? String,
                    let reportTypeStr = dataAsDictionary[WebRequestKeys.type] as? String,
                    let reportType = getAnalyticsType(from: reportTypeStr),
                    let startedAtStr = dataAsDictionary[WebRequestKeys.startedAt] as? String,
                    let startedAtDate = Date.convertZuluDateStringToLocalDate(startedAtStr),
                    let endedAtStr = dataAsDictionary[WebRequestKeys.endedAt] as? String,
                    let endedAtDate = Date.convertZuluDateStringToLocalDate(endedAtStr) else {
                        completionHandler(GetGameAnalyticsResult.failure(data, response, error))
                        return
                }
                let paginationToken = dataAsDictionary[WebRequestKeys.pagination] as? String
                completionHandler(
                    GetGameAnalyticsResult.success(url, reportType, startedAtDate, endedAtDate, gameId,
                                                   paginationToken))
            }.resume()
        }

        /// `convertGetExtensionAnalyticsParamsToDict` is used to convert the typed parameters into
        /// a list of web request parameters as a String-keyed Dictionary for a
        /// `getExtensionAnalytics` method call.
        ///
        /// - Parameters:
        ///   - after: input
        ///   - startedAt: input
        ///   - endedAt: input
        ///   - extensionId: input
        ///   - first: input
        ///   - type: input
        /// - Returns: The String-keyed `Dictionary` of parameters.
        private static func convertGetExtensionAnalyticsParamsToDict(after: String?, startedAt: Date?,
                                                                     endedAt: Date?, extensionId: String?,
                                                                     first: Int?,
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

        /// `convertGetGameAnalyticsParamsToDict` is used to convert the typed parameters into a
        /// list of web request parameters as a String-keyed Dictionary for a `getGameAnalytics`
        /// method call.
        ///
        /// - Parameters:
        ///   - after: input
        ///   - startedAt: input
        ///   - endedAt: input
        ///   - extensionId: input
        ///   - first: input
        ///   - type: input
        /// - Returns: The String-keyed `Dictionary` of parameters.
        private static func convertGameAnalyticsParamsToDict(after: String?, startedAt: Date?, endedAt: Date?,
                                                             gameId: String?, first: Int?,
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
            if let gameId = gameId {
                parametersDictionary[WebRequestKeys.gameId] = gameId
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
    
    // MARK: - Bits
    
    /// Bits is a category of Twitch API calls that interacts with "Bits". Bits are currency pieces
    /// that translate into real-world money.
    public struct Bits {
        
        /// `Period` defines the different types of periods that are accepted by the Twitch API for
        /// use in retrieving Bit Leaderboard statistics based on an amount of time.
        ///
        /// - all: Defines a period of the broadcaster's entire channel
        /// - day: Defines a period of one day specified at 00:00:00 on the `started_at` date
        /// - week: Defines a period of one week specified at 00:00:00 on the `started_at` date on a
        /// Monday through the next Monday
        /// - month: Defines a period of one month specified at 00:00:00 on the `started_at` date on
        /// the first day of the month until the last day of the month
        /// - year: Defines a period of the day specified at 00:00:00 on the `started_at` date on
        /// the first day of the year until the last day of the year
        public enum Period: String {
            case all = "all"
            case day = "day"
            case week = "week"
            case month = "month"
            case year = "year"
        }
        
        /// `GetBitsLeaderboardResult` defines the different types of results that can be retrieved
        /// from the `getBitsLeaderboard` call of the `Bits` API. Variables are included that
        /// specify the data that was returned.
        ///
        /// - success: Defines that the call was successful. The included variables should be input
        /// in the following order:
        /// 1. String - Specifies the username of the user that the call was done for
        /// 1. String - Specifies the iD of  the user that the call was done for
        /// 1. Int - Specifies the score of the user
        /// 1. Int - Specifies the rank of the user on the leaderboard
        /// 1. String - Specifies the Game ID of the analytics result
        /// 1. String? - Specifies the pagination token; `nil` if an extension ID was used in the
        /// call
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetBitsLeaderboardResult {
            // TODO: Change Success to be an object
            case success(String, String, Int, Int, Int, Date, Date)
            case failure(Data?, URLResponse?, Error?)
        }
        
        /// `getBitsLeaderboard` will run the `Get Bits Leaderboard` API call of the New
        /// Twitch API.
        ///
        /// This API call requires a token with `bits:read` permissions.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/reference/#get-bits-leaderboard)
        ///
        /// - Parameters:
        ///   - tokenManager: The TokenManager whose token should be used. Singleton by default.
        ///   - count: The maximum number of users to obtain data for on the leaderboard. Highest
        /// ranking users will be returned first.
        ///   - period: The period to obtain data for. If this value is `.all`, then `startedAt`
        /// will be ignored.
        ///   - startedAt: The `Date` for which the period should start for.
        ///   - userId: The id of the user to get Bit leaderboard results for.
        ///   - completionHandler: The function that should be run whenever the retrieval is
        /// successful. There are two types of `GetBitsLeaderboardResult`: `success` and `failure`.
        /// For more information on what values are returned, please see documentation on
        /// `GetGameAnalyticsResult`
        ///
        /// - seealso: `Period`
        /// - seealso: `GetBitsLeaderboardResult`
        public static func getBitsLeaderboard(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                              count: Int? = nil, period: Twitch.Bits.Period? = nil,
                                              startedAt: Date? = nil, userId: String? = nil,
                                              completionHandler: @escaping (GetBitsLeaderboardResult) -> Void) {
            
        }
    }

    /// Private initializer. The entire Twitch API can be accessed through static methods.
    private init() { }
}
