//
//  Twitch.swift
//  NewTwitchAPIWrapper
//
//  Created by Christopher Perkins on 12/14/18.
//

import Foundation
import Marshal

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
        static let before = "before"
        static let broadcasterId = "broadcaster_id"
        static let broadcasterName = "broadcaster_name"
        static let count = "count"
        static let createdAt = "created_at"
        static let creatorId = "creator_id"
        static let creatorName = "creator_name"
        static let data = "data"
        static let dateRange = "date_range"
        static let editURL = "edit_url"
        static let embedURL = "embed_url"
        static let endedAt = "ended_at"
        static let extensionId = "extension_id"
        static let first = "first"
        static let gameId = "game_id"
        static let hasDelay = "has_delay"
        static let id = "id"
        static let language = "language"
        static let pagination = "pagination"
        static let period = "period"
        static let rank = "rank"
        static let score = "score"
        static let startedAt = "started_at"
        static let thumbnailURL = "thumbnail_url"
        static let title = "title"
        static let total = "total"
        static let type = "type"
        static let url = "url"
        static let userId = "user_id"
        static let userName = "user_name"
        static let videoId = "video_id"
        static let viewCount = "view_count"
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

        /// `GetExtensionAnalyticsResult` defines the different types of results that can be
        /// retrieved from the `getExtensionAnalytics` call of the `Analytics` API. Variables are
        /// included that specify the data that was returned.
        ///
        /// - success: Defines that the call was successful. The output variable will contain all
        /// extension analytics data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetExtensionAnalyticsResult {
            case success(GetExtensionAnalyticsData)
            case failure(Data?, URLResponse?, Error?)
        }

        /// `GetGameAnalyticsResult` defines the different types of results that can be retrieved
        /// from the `getGameAnalytics` call of the `Analytics` API. Variables are included that
        /// specify the data that was returned.
        ///
        /// - success: Defines that the call was successful. The output variable will contain all
        /// game analytics data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetGameAnalyticsResult {
            case success(GetGameAnalyticsData)
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
            Twitch.performAPIWebRequest(
                to: extensionAnalyticsURL, withHTTPMethod: URLRequest.RequestHeaderTypes.get,
                withParameters: convertGetExtensionAnalyticsParamsToDict(after: after, startedAt: startedAt,
                                                                         endedAt: endedAt, extensionId: extensionId,
                                                                         first: first, type: type),
                withTokenManager: tokenManager,
                onSuccess: { completionHandler(GetExtensionAnalyticsResult.success($0)) },
                onFailure: { completionHandler(GetExtensionAnalyticsResult.failure($0, $1, $2)) })
        }

        /// `getGameAnalytics` will run the `Get Game Analytics` API call of the New
        /// Twitch API.
        ///
        /// This API call requires a token with `analytics:read:games` permissions.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/referenxce/#get-game-analytics)
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
            Twitch.performAPIWebRequest(
                to: gameAnalyticsURL, withHTTPMethod: URLRequest.RequestHeaderTypes.get,
                withParameters: convertGameAnalyticsParamsToDict(after: after, startedAt: startedAt,
                                                                 endedAt: endedAt, gameId: gameId, first: first,
                                                                 type: type),
                withTokenManager: tokenManager,
                onSuccess: { completionHandler(GetGameAnalyticsResult.success($0)) },
                onFailure: { completionHandler(GetGameAnalyticsResult.failure($0, $1, $2)) })
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
            parametersDictionary.addValueIfNotNil(after, toKey: WebRequestKeys.after)
            parametersDictionary.addValueIfNotNil(extensionId, toKey: WebRequestKeys.extensionId)
            parametersDictionary.addValueIfNotNil(first, toKey: WebRequestKeys.first)
            parametersDictionary.addValueIfNotNil(type?.rawValue, toKey: WebRequestKeys.type)

            if let startedAt = startedAt {
                parametersDictionary[WebRequestKeys.startedAt] = Date.convertDateToZuluString(startedAt)
            }
            if let endedAt = endedAt {
                parametersDictionary[WebRequestKeys.endedAt] = Date.convertDateToZuluString(endedAt)
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
        // Todo: rename to convertGetGameAnalyticsParamsToDict
        private static func convertGameAnalyticsParamsToDict(after: String?, startedAt: Date?, endedAt: Date?,
                                                             gameId: String?, first: Int?,
                                                             type: AnalyticsType?) -> [String: Any] {
            var parametersDictionary = [String: Any]()
            parametersDictionary.addValueIfNotNil(after, toKey: WebRequestKeys.after)
            parametersDictionary.addValueIfNotNil(gameId, toKey: WebRequestKeys.gameId)
            parametersDictionary.addValueIfNotNil(first, toKey: WebRequestKeys.first)
            parametersDictionary.addValueIfNotNil(type?.rawValue, toKey: WebRequestKeys.type)

            if let startedAt = startedAt {
                parametersDictionary[WebRequestKeys.startedAt] = Date.convertDateToZuluString(startedAt)
            }
            if let endedAt = endedAt {
                parametersDictionary[WebRequestKeys.endedAt] = Date.convertDateToZuluString(endedAt)
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
        /// - success: Defines that the call was successful. The output variable will contain all
        /// game analytics data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetBitsLeaderboardResult {
            // TODO: Change Success to be an object
            case success(GetBitsLeaderboardData)
            case failure(Data?, URLResponse?, Error?)
        }
        
        /// `bitsLeaderboardURL` is the URL that should be accessed for all bits leaderboard calls.
        private static let bitsLeaderboardURL = URL(string: "https://api.twitch.tv/helix/bits/leaderboard")!

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
        /// `GetBitsLeaderboardResult`
        ///
        /// - seealso: `Period`
        /// - seealso: `GetBitsLeaderboardResult`
        public static func getBitsLeaderboard(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                              count: Int? = nil, period: Twitch.Bits.Period? = nil,
                                              startedAt: Date? = nil, userId: String? = nil,
                                              completionHandler: @escaping (GetBitsLeaderboardResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: bitsLeaderboardURL, withHTTPMethod: URLRequest.RequestHeaderTypes.get,
                withParameters: convertGetBitsLeaderboardParamsToDict(count: count, period: period,
                                                                      startedAt: startedAt, userId: userId),
                withTokenManager: tokenManager,
                onSuccess: { completionHandler(GetBitsLeaderboardResult.success($0)) },
                onFailure: { completionHandler(GetBitsLeaderboardResult.failure($0, $1, $2)) })
        }

        /// `convertGetBitsLeaderboardParamsToDict` is used to convert the typed parameters into a
        /// list of web request parameters as a String-keyed Dictionary for a `getBitsLeaderboard`
        /// method call.
        ///
        /// - Parameters:
        ///   - count: input
        ///   - period: input
        ///   - startedAt: input
        ///   - userId: input
        /// - Returns: The String-keyed `Dictionary` of parameters.
        private static func convertGetBitsLeaderboardParamsToDict(count: Int?, period: Twitch.Bits.Period?,
                                                                  startedAt: Date?,
                                                                  userId: String?) -> [String: Any] {
            var parametersDictionary = [String: Any]()
            parametersDictionary.addValueIfNotNil(count, toKey: WebRequestKeys.count)
            parametersDictionary.addValueIfNotNil(period?.rawValue, toKey: WebRequestKeys.period)
            parametersDictionary.addValueIfNotNil(userId, toKey: WebRequestKeys.userId)

            if let startedAt = startedAt {
                parametersDictionary[WebRequestKeys.startedAt] =
                    Date.convertDateToZuluString(startedAt)
            }

            return parametersDictionary
        }
    }

    // MARK: - Clips

    /// Clips is a category of Twitch API calls that interacts with "Clips". Clips are short videos
    /// taken during live streams. Clips may be created or retrieved.
    public struct Clips {

        /// `CreateClipResult` defines the different types of results that can be retrieved from the
        /// `createClip` call of the `Clips` API. Variables are included that specify the data that
        /// was returned.
        ///
        /// - success: Defines that the call was successful. The output variable will contain all
        /// clip response data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum CreateClipResult {
            case success(CreateClipData)
            case failure(Data?, URLResponse?, Error?)
        }

        /// `GetClipsResult` defines the different types of results that can be retrieved from the
        /// `Get Clips` call of the `Clips` API. Variables are included that specify the data that
        /// was returned.
        ///
        /// - success: Defines that the call was successful. The output variable will contain all
        /// clip response data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetClipsResult {
            case success(GetClipsData)
            case failure(Data?, URLResponse?, Error?)
        }

        /// `bitsLeaderboardURL` is the URL that should be accessed for all bits leaderboard calls.
        private static let clipsURL = URL(string: "https://api.twitch.tv/helix/clips")!

        /// `clipIdDelimiter` is used to specify the `String` that separates multiple clip IDs in a
        /// web request.
        private static let clipIdDelimiter = ","

        /// `createClip` will run the `Create Clip` API call of the New Twitch API.
        ///
        /// This API call requires a token with `clips:edit` permissions.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/reference/#create-clip)
        ///
        /// - Parameters:
        ///   - broadcasterId: The ID of the broadcaster to create a clip for.
        ///   - hasDelay: if `true`, delay is added to account for the delay between the actual
        /// stream and when they would experience that moment in the stream. If `false`, then the
        /// clip is captured at the immediate moment with no delay. The default value is `false`.
        ///   - completionHandler: The function that should be run whenever the retrieval is
        /// successful. There are two types of `CreateClipResult`: `success` and `failure`.
        /// For more information on what values are returned, please see documentation on
        /// `CreateClipResult`
        ///
        /// - seealso: `CreateClipResult`
        public static func createClip(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                      broadcasterId: String, hasDelay: Bool? = nil,
                                      completionHandler: @escaping (CreateClipResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: clipsURL, withHTTPMethod: URLRequest.RequestHeaderTypes.post,
                withParameters: convertCreateClipParamsToDict(broadcasterId: broadcasterId, hasDelay: hasDelay),
                withTokenManager: tokenManager,
                onSuccess: { completionHandler(CreateClipResult.success($0)) },
                onFailure: { completionHandler(CreateClipResult.failure($0, $1, $2)) })
        }

        /// `createClip` will run the `Create Clip` API call of the New Twitch API. A broadcaster
        /// ID, game ID, or clip IDs must be provided.
        ///
        /// This API call requires no special permissions.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/reference/#get-clips)
        ///
        /// - Parameters:
        ///   - tokenManager: The TokenManager whose token should be used. Singleton by default.
        ///   - broadcasterId: The ID of the broadcaster to retrieve clips for. Must be specified if
        /// no other specification exists.
        ///   - gameId: The ID of the game to retrieve clips for. Must be specified if no other
        /// specification exists.
        ///   - clipIds: The ID of the clips to retrieve. Maximum of 100. Must be specified if no
        /// other specification exists.
        ///   - after: The backwards pagination token
        ///   - before: The backwards pagination token
        ///   - startedAt: The preceding date in the past where all clips should be created after
        ///   - endedAt: The proceeding date in the past where all clips should be created before
        ///   - first: The maximum number of clips to retrieve. Default of 20; maximum of 100.
        ///   - completionHandler: The function that should be run whenever the retrieval is
        /// successful. There are two types of `GetClipsResult`: `success` and `failure`.
        /// For more information on what values are returned, please see documentation on
        /// `GetClipsResult`
        ///
        /// - seealso: `Period`
        /// - seealso: `GetClipsResult`
        public static func getClips(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                    broadcasterId: String? = nil, gameId: String? = nil, clipIds: [String]? = nil,
                                    after: String? = nil, before: String? = nil, startedAt: Date? = nil,
                                    endedAt: Date? = nil, first: Int? = nil,
                                    completionHandler: @escaping (GetClipsResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: clipsURL, withHTTPMethod: URLRequest.RequestHeaderTypes.get,
                withParameters: convertGetClipsParamsToDict(broadcasterId: broadcasterId, gameId: gameId,
                                                            clipIds: clipIds, before: before, after: after,
                                                            startedAt: startedAt, endedAt: endedAt, first: first),
                withTokenManager: tokenManager,
                onSuccess: { completionHandler(GetClipsResult.success($0)) },
                onFailure: { completionHandler(GetClipsResult.failure($0, $1, $2)) })
        }

        /// `convertCreateClipParamsToDict` is used to convert the typed parameters into a list of
        /// web request parameters as a String-keyed Dictionary for a `createClip` method call.
        ///
        /// - Parameters:
        ///   - broadcasterId: input
        ///   - hasDelay: input
        /// - Returns: The String-keyed `Dictionary` of parameters.
        private static func convertCreateClipParamsToDict(broadcasterId: String,
                                                          hasDelay: Bool?) -> [String: Any] {
            var parametersDictionary = [String: Any]()
            parametersDictionary[WebRequestKeys.broadcasterId] = broadcasterId
            parametersDictionary.addValueIfNotNil(hasDelay, toKey: WebRequestKeys.hasDelay)
            return parametersDictionary
        }

        /// `convertGetClipsParamsToDict` is used to convert the typed parameters into a list of
        /// web request parameters as a String-keyed Dictionary for a `createClip` method call.
        ///
        /// - Parameters:
        ///   - broadcasterId: input
        ///   - gameId: input
        ///   - clipIds: input
        ///   - before: input
        ///   - after: input
        ///   - startedAt: input
        ///   - endedAt: input
        ///   - first: input
        /// - Returns: The String-keyed `Dictionary` of parameters.
        private static func convertGetClipsParamsToDict(broadcasterId: String?, gameId: String?, clipIds: [String]?,
                                                        before: String?, after: String?, startedAt: Date?,
                                                        endedAt: Date?, first: Int?) -> [String: Any] {
            var parametersDictionary = [String: Any]()
            parametersDictionary.addValueIfNotNil(broadcasterId, toKey: WebRequestKeys.broadcasterId)
            parametersDictionary.addValueIfNotNil(gameId, toKey: WebRequestKeys.gameId)
            parametersDictionary.addValueIfNotNil(before, toKey: WebRequestKeys.before)
            parametersDictionary.addValueIfNotNil(after, toKey: WebRequestKeys.after)
            parametersDictionary.addValueIfNotNil(first, toKey: WebRequestKeys.first)

            if let clipIds = clipIds {
                parametersDictionary[WebRequestKeys.id] = clipIds.joined(separator: clipIdDelimiter)
            }
            if let startedAt = startedAt {
                parametersDictionary[WebRequestKeys.startedAt] = Date.convertDateToZuluString(startedAt)
            }
            if let endedAt = endedAt {
                parametersDictionary[WebRequestKeys.endedAt] = Date.convertDateToZuluString(endedAt)
            }
            return parametersDictionary
        }
    }

    // MARK: - Twitch Functions

    /// `performAPIWebRequest` will create a Web Request destined for the New Twitch API. The URL,
    /// httpMethod, parameters, and a token manager must be provided in order to create a Twitch
    /// URL Request. By calling this function, a URLRequest whose authorization bearer, httpMethod,
    /// and httpBody are set will be created. Should this web request fail for any reason, the
    /// `failureHandler` will be called. If the request is successful, then `successHandler` will
    /// be called instead.
    ///
    /// - Parameters:
    ///   - url: The URL to perform the web request to
    ///   - httpMethod: The method to perform the url request with
    ///   - parameters: The parameters of the web request
    ///   - tokenManager: The token manager that is used to provide authentication
    ///   - successHandler: The handler for a successful web request
    ///   - failureHandler: The handler for a failed web request
    private static func performAPIWebRequest<T: Unmarshaling>(
        to url: URL, withHTTPMethod httpMethod: String?, withParameters parameters: [String: Any],
        withTokenManager tokenManager: TwitchTokenManager, onSuccess successHandler: @escaping (T) -> Void,
        onFailure failureHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {

        var request = URLRequest(url: url.withQueryItems(parameters))
        do {
            try request.addTokenAuthorizationHeader(fromTokenManager: tokenManager)
        } catch {
            failureHandler(nil, nil, error)
            return
        }

        request.setValueToJSONContentType()
        request.httpMethod = httpMethod

        urlSessionForWrapper.dataTask(with: request) { (data, response, error) in
            guard let nonNilData = data, let dataAsDictionary = nonNilData.getAsDictionary(),
                let retrievedObject = try? T(object: dataAsDictionary),
                !Twitch.getIfErrorOccurred(data: data, response: response, error: error) else {
                    failureHandler(data, response, error)
                    return
            }
            successHandler(retrievedObject)
        }.resume()
    }

    /// `getIfErrorOccurred` is a quick function used by URLTask Completion Handlers for determining
    /// if an error occurred during the web request.
    ///
    /// Errors are said to occur in three situations:
    /// 1. The error is **not** `nil`
    /// 1. The response is `nil`
    /// 1. The response status code is not `200`
    ///
    /// - Parameters:
    ///   - data: The data received
    ///   - response: The response received
    ///   - error: The error received
    /// - Returns: Whether or not an error occured during the web request.
    private static func getIfErrorOccurred(data: Data?, response: URLResponse?, error: Error?) -> Bool {
        guard let response = response, let httpStatus = response as? HTTPURLResponse,
            error == nil && httpStatus.statusCode == 200 else {
                return true
        }
        return false
    }

    /// Private initializer. The entire Twitch API can be accessed through static methods.
    private init() { }
}
