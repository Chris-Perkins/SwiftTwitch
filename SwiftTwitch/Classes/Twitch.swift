//
//  Twitch.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/14/18.
//

import Foundation
import Marshal

/// `Twitch` allows access to client-side New Twitch API functions.
///
/// The following structures contain the different endpoints you can hit in the New Twitch API:
/// * Analytics - Access via `Twitch.Analytics`
/// * Bits - Access via `Twitch.Bits`
/// * Clips - Access via `Twitch.Clips`
/// * Games - Access via `Twitch.Games`
/// * Streams - Access via `Twitch.Streams`
/// * Users - Access via `Twitch.Users`
/// * Videos - Access via `Twitch.Videos`
///
/// [The complete API reference is available here](https://dev.twitch.tv/docs/api/reference/)
public class Twitch {

    // TODO: Do not use the shared singleton as it may have its delegate set up already. This may
    // cause unexpected delegate method receivals.
    /// `urlSessionForWrapper` is a singleton for all Twitch API calls that will be used for.
    private static let urlSessionForWrapper: URLSession = URLSession.shared

    // TODO: Move this to a separate file for readability?
    /// `WebRequestKeys` define the web request keys for both resolving results and sending requests
    /// for the New Twitch API.
    internal struct WebRequestKeys {
        static let ability = "ability"
        static let after = "after"
        static let before = "before"
        static let boxArtURL = "box_art_url"
        static let broadcaster = "broadcaster"
        static let broadcasterId = "broadcaster_id"
        static let broadcasterName = "broadcaster_name"
        static let broadcasterType = "broadcaster_type"
        static let canActivate = "can_activate"
        static let classKey = "class"
        static let communityId = "community_id"
        static let communityIds = "community_ids"
        static let count = "count"
        static let createdAt = "created_at"
        static let creatorId = "creator_id"
        static let creatorName = "creator_name"
        static let cursor = "cursor"
        static let data = "data"
        static let dateRange = "date_range"
        static let description = "description"
        static let displayName = "display_name"
        static let duration = "duration"
        static let editURL = "edit_url"
        static let email = "email"
        static let embedURL = "embed_url"
        static let endedAt = "ended_at"
        static let extensionId = "extension_id"
        static let first = "first"
        static let followedAt = "followed_at"
        static let fromId = "from_id"
        static let fromName = "from_name"
        static let gameId = "game_id"
        static let hasDelay = "has_delay"
        static let hearthstone = "hearthstone"
        static let hero = "hero"
        static let id = "id"
        static let language = "language"
        static let login = "login"
        static let manifestId = "manifest_id"
        static let markers = "markers"
        static let name = "name"
        static let offlineImageURL = "offline_image_url"
        static let opponent = "opponent"
        static let overwatch = "overwatch"
        static let pagination = "pagination"
        static let period = "period"
        static let positionSeconds = "position_seconds"
        static let profileImageURL = "profile_image_url"
        static let publishedAt = "published_at"
        static let rank = "rank"
        static let role = "role"
        static let score = "score"
        static let startedAt = "started_at"
        static let sort = "sort"
        static let thumbnailURL = "thumbnail_url"
        static let title = "title"
        static let toId = "to_id"
        static let toName = "to_name"
        static let total = "total"
        static let type = "type"
        static let url = "url"
        static let userId = "user_id"
        static let userLogin = "user_login"
        static let userName = "user_name"
        static let version = "version"
        static let videoId = "video_id"
        static let videos = "videos"
        static let viewable = "viewable"
        static let viewCount = "view_count"
        static let viewerCount = "viewer_count"
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
        /// Twitch API. You can use this API call to retrieve data regarding the usage of extensions
        /// for the token-bearing user. This data will be available for download in a URL that is
        /// retrieved from this API call.
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
        /// `failure`.
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
                withQueryParameters: convertGetExtensionAnalyticsParamsToDict(after: after, startedAt: startedAt,
                                                                              endedAt: endedAt,
                                                                              extensionId: extensionId,
                                                                              first: first, type: type),
                withBodyParameters: nil, enforcesAuthorization: true, withTokenManager: tokenManager,
                onSuccess: { completionHandler(GetExtensionAnalyticsResult.success($0)) },
                onFailure: { completionHandler(GetExtensionAnalyticsResult.failure($0, $1, $2)) })
        }

        /// `getGameAnalytics` will run the `Get Game Analytics` API call of the New Twitch API.
        /// You can use this API call to retrieve data regarding the usage of games for the
        /// token-bearing user. This data will be available for download in a URL that is retrieved
        /// from this API call.
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
        ///
        /// - seealso: `AnalyticsType`
        /// - seealso: `GetGameAnalyticsResult`
        public static func getGameAnalytics(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                            after: String? = nil, startedAt: Date? = nil, endedAt: Date? = nil,
                                            gameId: String? = nil, first: Int? = nil, type: AnalyticsType? = nil,
                                            completionHandler: @escaping (GetGameAnalyticsResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: gameAnalyticsURL, withHTTPMethod: URLRequest.RequestHeaderTypes.get,
                withQueryParameters: convertGetGameAnalyticsParamsToDict(after: after, startedAt: startedAt,
                                                                         endedAt: endedAt, gameId: gameId,
                                                                         first: first, type: type),
                withBodyParameters: nil, enforcesAuthorization: true, withTokenManager: tokenManager,
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
        private static func convertGetGameAnalyticsParamsToDict(after: String?, startedAt: Date?, endedAt: Date?,
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
        /// bit leaderboard data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetBitsLeaderboardResult {
            case success(GetBitsLeaderboardData)
            case failure(Data?, URLResponse?, Error?)
        }

        /// `bitsLeaderboardURL` is the URL that should be accessed for all bits leaderboard calls.
        private static let bitsLeaderboardURL = URL(string: "https://api.twitch.tv/helix/bits/leaderboard")!

        /// `getBitsLeaderboard` will run the `Get Bits Leaderboard` API call of the New Twitch API.
        /// This API call can be used to retrieve the leaderboard of bits for the streamer who is
        /// authenticated. Results can be filtered by a date range or by user IDs. If no User ID
        /// filter is applied, results are returned in descending rank-order (highest first).
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
        ///
        /// - seealso: `Period`
        /// - seealso: `GetBitsLeaderboardResult`
        public static func getBitsLeaderboard(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                              count: Int? = nil, period: Twitch.Bits.Period? = nil,
                                              startedAt: Date? = nil, userId: String? = nil,
                                              completionHandler: @escaping (GetBitsLeaderboardResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: bitsLeaderboardURL, withHTTPMethod: URLRequest.RequestHeaderTypes.get,
                withQueryParameters: convertGetBitsLeaderboardParamsToDict(count: count, period: period,
                                                                           startedAt: startedAt,
                                                                           userId: userId),
                withBodyParameters: nil, enforcesAuthorization: true, withTokenManager: tokenManager,
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

        /// `clipsURL` is the URL that should be accessed for all bits leaderboard calls.
        private static let clipsURL = URL(string: "https://api.twitch.tv/helix/clips")!

        /// `createClip` will run the `Create Clip` API call of the New Twitch API. This method
        /// can be used to create a clip from a stream programmatically. Twitch suggests to run
        /// the `Get Clips` method to retrieve the created clip.
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
        ///   - completionHandler: The function that should be run whenever the post is successful.
        /// There are two types of `CreateClipResult`: `success` and `failure`.
        ///
        /// - seealso: `CreateClipResult`
        public static func createClip(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                      broadcasterId: String, hasDelay: Bool? = nil,
                                      completionHandler: @escaping (CreateClipResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: clipsURL, withHTTPMethod: URLRequest.RequestHeaderTypes.post,
                withQueryParameters: convertCreateClipParamsToDict(broadcasterId: broadcasterId,
                                                                   hasDelay: hasDelay),
                withBodyParameters: nil, enforcesAuthorization: true, withTokenManager: tokenManager,
                onSuccess: { completionHandler(CreateClipResult.success($0)) },
                onFailure: { completionHandler(CreateClipResult.failure($0, $1, $2)) })
        }

        /// `getClips` will run the `Get Clips` API call of the New Twitch API. A broadcaster ID,
        /// game ID, or clip IDs must be provided. This method can be used to retrieve clips based
        /// on specified filters.
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
        ///
        /// - seealso: `Period`
        /// - seealso: `GetClipsResult`
        public static func getClips(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                    broadcasterId: String?, gameId: String?, clipIds: [String]?,
                                    after: String? = nil, before: String? = nil, startedAt: Date? = nil,
                                    endedAt: Date? = nil, first: Int? = nil,
                                    completionHandler: @escaping (GetClipsResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: clipsURL, withHTTPMethod: URLRequest.RequestHeaderTypes.get,
                withQueryParameters: convertGetClipsParamsToDict(broadcasterId: broadcasterId, gameId: gameId,
                                                                 clipIds: clipIds, before: before,
                                                                 after: after, startedAt: startedAt,
                                                                 endedAt: endedAt, first: first),
                withBodyParameters: nil, enforcesAuthorization: false, withTokenManager: tokenManager,
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
            parametersDictionary.addValueIfNotNil(clipIds, toKey: WebRequestKeys.id)
            if let startedAt = startedAt {
                parametersDictionary[WebRequestKeys.startedAt] = Date.convertDateToZuluString(startedAt)
            }
            if let endedAt = endedAt {
                parametersDictionary[WebRequestKeys.endedAt] = Date.convertDateToZuluString(endedAt)
            }
            return parametersDictionary
        }
    }

    // MARK: - Games

    /// Games is a category of Twitch API calls that interacts with "Games" on Twitch. Despite
    /// the name, "Games" can refer to podcasts, art, or other streaming categories.
    public struct Games {

        /// `GetTopGamesResult` defines the different types of results that can be
        /// retrieved from the `getTopGames` call of the `Games` API. Variables are
        /// included that specify the data that was returned.
        ///
        /// - success: Defines that the call was successful. The output variable will contain all
        /// returned data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetTopGamesResult {
            case success(GetTopGamesData)
            case failure(Data?, URLResponse?, Error?)
        }

        /// `GetGamesResult` defines the different types of results that can be retrieved from the
        /// `getGames` call of the `Games` API. Variables are included that specify the data that
        /// was returned.
        ///
        /// - success: Defines that the call was successful. The output variable will contain all
        /// returned data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetGamesResult {
            case success(GetGamesData)
            case failure(Data?, URLResponse?, Error?)
        }

        /// The URL that will be used for the `Get Top Games` API call.
        private static let getTopGamesURL = URL(string: "https://api.twitch.tv/helix/games/top")!

        /// The URL that will be used for the `Get Games` API call.
        private static let getGamesURL = URL(string: "https://api.twitch.tv/helix/games")!

        /// `getTopGames` will run the `Get Top Games` API call of the New Twitch API. This API call
        /// can be used to retrieve the top games being streamed on Twitch in a paginated fashion.
        ///
        /// This method does **not** require a `TwitchTokenManager`. No Authorization is required.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/reference/#get-top-games)
        ///
        /// - Parameters:
        ///   - tokenManager: The TokenManager whose token should be used. Singleton by default.
        ///   - after: The forward pagination token of the call.
        ///   - before: The backwards pagination token of the call.
        ///   - first: The number of objects to retrieve. Maximum 100. Default 20.
        ///   - completionHandler: The function that should be run whenever the retrieval is
        /// successful. There are two types of `GetTopGamesResult`: `success` and
        /// `failure`.
        ///
        /// - seealso: `GetTopGamesResult`
        public static func getTopGames(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                       after: String? = nil, before: String? = nil, first: Int? = nil,
                                       completionHandler: @escaping (GetTopGamesResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: getTopGamesURL, withHTTPMethod: URLRequest.RequestHeaderTypes.get,
                withQueryParameters: convertGetTopGamesParamsToDict(after: after, before: before,
                                                                    first: first),
                withBodyParameters: nil, enforcesAuthorization: false, withTokenManager: tokenManager,
                onSuccess: { completionHandler(GetTopGamesResult.success($0)) },
                onFailure: { completionHandler(GetTopGamesResult.failure($0, $1, $2)) })
        }

        /// `getGames` will run the `Get Games` API call of the New Twitch API. This method can
        /// be used to get data regarding input game parameters. For instance, you can retrieve the
        /// ID of a game based on its name and vice-versa. A mix of IDs and names can be mixed to
        /// retrieve all data at once.
        ///
        /// This method does **not** require a `TwitchTokenManager`. No Authorization is required.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/reference/#get-games)
        ///
        /// - Parameters:
        ///   - tokenManager: The TokenManager whose token should be used. Singleton by default.
        ///   - gameIds: The IDs of the games to retrieve information for. Max 100. This does not
        /// need to be specified if `gameNames` is not `nil`.
        ///   - gameNames: The names of the games to retrieve information for. These MUST be exact
        /// matches. E.g.: "Super Smash Bros." will not resolve, but "Super Smash Bros. Ultimate"
        /// will. Max 100. This does not need to be specified if `gameIds` is not `nil`.
        ///   - completionHandler: The function that should be run whenever the retrieval is
        /// successful. There are two types of `GetTopGamesResult`: `success` and
        /// `failure`.
        ///
        /// - seealso: `GetGamesResult`
        public static func getGames(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                    gameIds: [String]?, gameNames: [String]?,
                                    completionHandler: @escaping (GetGamesResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: getGamesURL, withHTTPMethod: URLRequest.RequestHeaderTypes.get,
                withQueryParameters: convertGetGamesParamsToDict(gameIds: gameIds, gameNames: gameNames),
                withBodyParameters: nil, enforcesAuthorization: false, withTokenManager: tokenManager,
                onSuccess: { completionHandler(GetGamesResult.success($0)) },
                onFailure: { completionHandler(GetGamesResult.failure($0, $1, $2)) })
        }

        /// `convertGetTopGamesParamsToDict` is used to convert the typed parameters into a list of
        /// web request parameters as a String-keyed Dictionary for a `getTopGames` method call.
        ///
        /// - Parameters:
        ///   - after: input
        ///   - startedAt: input
        ///   - endedAt: input
        ///   - extensionId: input
        ///   - first: input
        ///   - type: input
        /// - Returns: The String-keyed `Dictionary` of parameters.
        private static func convertGetTopGamesParamsToDict(after: String?, before: String?,
                                                           first: Int?) -> [String: Any] {
            var parametersDictionary = [String: Any]()
            parametersDictionary.addValueIfNotNil(after, toKey: WebRequestKeys.after)
            parametersDictionary.addValueIfNotNil(before, toKey: WebRequestKeys.before)
            parametersDictionary.addValueIfNotNil(first, toKey: WebRequestKeys.first)
            return parametersDictionary
        }

        /// `convertGetGamesParamsToDict` is used to convert the typed parameters into a list of web
        /// request parameters as a String-keyed Dictionary for a `getGames` method call.
        ///
        /// - Parameters:
        ///   - gameIds: input
        ///   - gameNames: input
        /// - Returns: The String-keyed `Dictionary` of parameters.
        private static func convertGetGamesParamsToDict(gameIds: [String]?, gameNames: [String]?) -> [String: Any] {
            var parametersDictionary = [String: Any]()
            parametersDictionary.addValueIfNotNil(gameIds, toKey: WebRequestKeys.id)
            parametersDictionary.addValueIfNotNil(gameNames, toKey: WebRequestKeys.name)
            return parametersDictionary
        }
    }

    // MARK: - Streams

    /// Streams is a category of Twitch API calls that interacts with "Streams" on Twitch.
    public struct Streams {

        /// `GetStreamsResult` defines the different types of results that can be retrieved from the
        /// `getStreams` call of the `Streams` API. Variables are included that specify the data that
        /// was returned.
        ///
        /// - success: Defines that the call was successful. The output variable will contain all
        /// returned data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetStreamsResult {
            case success(GetStreamsData)
            case failure(Data?, URLResponse?, Error?)
        }

        /// `GetStreamsMetadataResult` defines the different types of results that can be retrieved
        /// from the `getStreamsMetadata` call of the `Sttreams` API. Variables are included that
        /// specify the data that was returned.
        ///
        /// - success: Defines that the call was successful. The output variable will contain all
        /// returned data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetStreamsMetadataResult {
            case success(GetStreamsMetadataData)
            case failure(Data?, URLResponse?, Error?)
        }

        /// `CreateStreamMarkerResult` defines the different types of results that can be retrieved
        /// from the `createStreamMarker` call of the `Games` API. Variables are included that
        /// specify the data that was returned.
        ///
        /// - success: Defines that the call was successful. The output variable will contain all
        /// returned data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum CreateStreamMarkerResult {
            case success(CreateStreamMarkerData)
            case failure(Data?, URLResponse?, Error?)
        }

        /// `GetStreamMarkersResult` defines the different types of results that can be retrieved
        /// from the `getStreamMarkers` call of the `Games` API. Variables are included that specify
        /// the data that was returned.
        ///
        /// - success: Defines that the call was successful. The output variable will contain all
        /// returned data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetStreamMarkersResult {
            case success(GetStreamMarkersData)
            case failure(Data?, URLResponse?, Error?)
        }

        /// The URL that will be used for the `Get Streams` API call.
        private static let getStreamsURL = URL(string: "https://api.twitch.tv/helix/streams")!

        /// The URL that will be used for the `Get Streams Metadata` API call.
        private static let getStreamsMetadataURL = URL(string: "https://api.twitch.tv/helix/streams/metadata")!

        /// The URL that will be used for all Stream Markers API calls.
        private static let streamMarkersURL = URL(string: "https://api.twitch.tv/helix/streams/markers")!

        /// `getStreams` will run the `Get Streams` API call of the New Twitch API. The returned
        /// streams are sorted in descending order such that the most-watched streamer is returned
        /// first in the received data.
        ///
        /// This method does **not** require a `TwitchTokenManager`. No Authorization is required.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/reference/#get-streams)
        ///
        /// - Parameters:
        ///   - tokenManager: The TokenManager whose token should be used. Singleton by default.
        ///   - after: The forward pagination token.
        ///   - before: The backwards pagination token.
        ///   - communityIds: Specifies that streams from the specified communities should be
        /// returned. Up to 100 IDs are possible.
        ///   - first: The maximum number of streams to return. Maximum 100. Default 20.
        ///   - gameIds: The IDs of the games to retrieve streams for. Maximum 100.
        ///   - languages: The languages of streams that should be received. Maximum 100.
        ///   - userIds: The IDs of the users whose streams should be retrieved. Maximum 100.
        ///   - userNames: The names of the users whose streams should be retrieved. Maximum 100.
        ///   - completionHandler: The function that should be run whenever the retrieval is
        /// successful. There are two types of `GetStreamsResult`: `success` and `failure`.
        ///
        /// - seealso: `GetStreamsResult`
        public static func getStreams(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                      after: String? = nil, before: String? = nil, communityIds: [String]? = nil,
                                      first: Int? = nil, gameIds: [String]? = nil, languages: [String]? = nil,
                                      userIds: [String]? = nil, userNames: [String]? = nil,
                                      completionHandler: @escaping (GetStreamsResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: getStreamsURL, withHTTPMethod: URLRequest.RequestHeaderTypes.get,
                withQueryParameters: convertGetStreamsParamsToDict(after: after, before: before,
                                                                   communityIds: communityIds, first: first,
                                                                   gameIds: gameIds, languages: languages,
                                                                   userIds: userIds, userNames: userNames),
                withBodyParameters: nil, enforcesAuthorization: false, withTokenManager: tokenManager,
                onSuccess: { completionHandler(GetStreamsResult.success($0)) },
                onFailure: { completionHandler(GetStreamsResult.failure($0, $1, $2)) })
        }

        /// `getStreamsMetadata` will run the `Get Streams Metadata` API call of the New Twitch API.
        /// The returned streams are sorted in descending order such that the most-watched streamer
        /// is returned first in the received data. This data contains special information about
        /// streamers who are playing Overwatch or Hearthstone!
        ///
        /// This method does **not** require a `TwitchTokenManager`. No Authorization is required.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/reference/#get-streams-metadata)
        ///
        /// - Parameters:
        ///   - tokenManager: The TokenManager whose token should be used. Singleton by default.
        ///   - after: The forward pagination token.
        ///   - before: The backwards pagination token.
        ///   - communityIds: Specifies that streams from the specified communities should be
        /// returned. Up to 100 IDs are possible.
        ///   - first: The maximum number of streams to return. Maximum 100. Default 20.
        ///   - gameIds: The IDs of the games to retrieve streams for. Maximum 100.
        ///   - languages: The languages of streams that should be received. Maximum 100.
        ///   - userIds: The IDs of the users whose streams should be retrieved. Maximum 100.
        ///   - userNames: The names of the users whose streams should be retrieved. Maximum 100.
        ///   - completionHandler: The function that should be run whenever the retrieval is
        /// successful. There are two types of `GetStreamsMetadataResult`: `success` and `failure`.
        ///
        /// - seealso: `GetStreamsMetadataResult`
        public static func getStreamsMetadata(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                              after: String? = nil, before: String? = nil,
                                              communityIds: [String]? = nil, first: Int? = nil,
                                              gameIds: [String]? = nil, languages: [String]? = nil,
                                              userIds: [String]? = nil, userNames: [String]? = nil,
                                              completionHandler: @escaping (GetStreamsMetadataResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: getStreamsMetadataURL, withHTTPMethod: URLRequest.RequestHeaderTypes.get,
                withQueryParameters: convertGetStreamsParamsToDict(after: after, before: before,
                                                                   communityIds: communityIds,
                                                                   first: first, gameIds: gameIds,
                                                                   languages: languages, userIds: userIds,
                                                                   userNames: userNames),
                withBodyParameters: nil, enforcesAuthorization: false, withTokenManager: tokenManager,
                onSuccess: { completionHandler(GetStreamsMetadataResult.success($0)) },
                onFailure: { completionHandler(GetStreamsMetadataResult.failure($0, $1, $2)) })
        }

        /// `createStreamMarker` will run the `Create Stream Marker` API call of the New Twitch API.
        /// Stream Markers are points in streams that the Streamer or Editor wants to mark so that
        /// they can return to that point later. The marker will be created at the current timestamp
        /// of the livestream.
        ///
        /// This method does requires `user:edit:broadcast` permissions on a user who is an editor
        /// or streamer of the stream where the stream marker should be created.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/reference/#create-stream-marker)
        ///
        /// - Parameters:
        ///   - tokenManager: The TokenManager whose token should be used. Singleton by default.
        ///   - userId: The ID of the user who's stream should be marked at the current time
        ///   - description: The description of the marker.
        ///   - completionHandler: The function that should be run whenever the post is successful.
        /// There are two types of `CreateStreamMarkerResult`: `success` and `failure`.
        ///
        /// - seealso: `CreateStreamMarkerResult`
        public static func createStreamMarker(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                              userId: String, description: String? = nil,
                                              completionHandler: @escaping (CreateStreamMarkerResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: streamMarkersURL, withHTTPMethod: URLRequest.RequestHeaderTypes.post,
                withQueryParameters: nil,
                withBodyParameters: convertCreateStreamMarkerParamsToDict(userId: userId, description: description),
                enforcesAuthorization: true, withTokenManager: tokenManager,
                onSuccess: { completionHandler(CreateStreamMarkerResult.success($0)) },
                onFailure: { completionHandler(CreateStreamMarkerResult.failure($0, $1, $2)) })
        }

        /// `getStreamMarkers` will run the `Get Stream Markers` API call of the New Twitch API.
        /// Stream Markers are points in streams that the Streamer or Editor wants to mark so that
        /// they can return to that point later. The marker will be created at the current timestamp
        /// of the livestream.
        ///
        /// This method does requires `user:read:broadcast` permissions on a user who is an editor
        /// or streamer of the stream where the stream marker should be created.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/reference/#get-stream-markers)
        ///
        /// - Parameters:
        ///   - tokenManager: The TokenManager whose token should be used. Singleton by default.
        ///   - userId: The ID of the user whose stream markers should be obtained
        ///   - videoId: The ID of the video whose stream markers should be obtained
        ///   - after: The forward pagination token.
        ///   - before: The backwards pagination token.
        ///   - communityIds: Specifies that streams from the specified communities should be
        /// returned. Up to 100 IDs are possible.
        ///   - first: The maximum number of streams to return. Maximum 100. Default 20.
        /// successful. There are two types of `CreateStreamMarkerResult`: `success` and `failure`.
        ///
        /// - seealso: `CreateStreamMarkerResult`
        public static func getStreamMarkers(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                            userId: String, videoId: String, after: String? = nil,
                                            before: String? = nil, first: Int? = nil,
                                            completionHandler: @escaping (GetStreamMarkersResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: streamMarkersURL, withHTTPMethod: URLRequest.RequestHeaderTypes.get,
                withQueryParameters: convertGetStreamMarkersParamsToDict(userId: userId, videoId: videoId,
                                                                         after: after, before: before,
                                                                         first: first),
                withBodyParameters: nil, enforcesAuthorization: true, withTokenManager: tokenManager,
                onSuccess: { completionHandler(GetStreamMarkersResult.success($0)) },
                onFailure: { completionHandler(GetStreamMarkersResult.failure($0, $1, $2)) })
        }

        /// `convertGetStreamsParamsToDict` is used to convert the typed parameters into a list of
        /// web request parameters as a String-keyed Dictionary for a `getStreams` method call.
        ///
        /// - Parameters:
        ///   - after: input
        ///   - before: input
        ///   - communityIds: input
        ///   - first: input
        ///   - gameIds: input
        ///   - languages: input
        ///   - userIds: input
        ///   - userNames: input
        /// - Returns: The String-keyed `Dictionary` of parameters.
        private static func convertGetStreamsParamsToDict(after: String?, before: String?, communityIds: [String]?,
                                                          first: Int?, gameIds: [String]?, languages: [String]?,
                                                          userIds: [String]?,
                                                          userNames: [String]?) -> [String: Any] {
            var parametersDictionary = [String: Any]()
            parametersDictionary.addValueIfNotNil(after, toKey: WebRequestKeys.after)
            parametersDictionary.addValueIfNotNil(before, toKey: WebRequestKeys.before)
            parametersDictionary.addValueIfNotNil(first, toKey: WebRequestKeys.first)
            parametersDictionary.addValueIfNotNil(communityIds, toKey: WebRequestKeys.communityId)
            parametersDictionary.addValueIfNotNil(gameIds, toKey: WebRequestKeys.gameId)
            parametersDictionary.addValueIfNotNil(languages, toKey: WebRequestKeys.language)
            parametersDictionary.addValueIfNotNil(userIds, toKey: WebRequestKeys.userId)
            parametersDictionary.addValueIfNotNil(userNames, toKey: WebRequestKeys.userLogin)
            return parametersDictionary
        }

        /// `convertCreateStreamMarkerParamsToDict` is used to convert the typed parameters into a
        /// list of web request parameters as a String-keyed Dictionary for a `createStreamMarker`
        /// method call.
        ///
        /// - Parameters:
        ///   - userId: input
        ///   - description: input
        /// - Returns: The String-keyed `Dictionary` of parameters.
        private static func convertCreateStreamMarkerParamsToDict(userId: String,
                                                                  description: String?) -> [String: Any] {
            var parametersDictionary = [String: Any]()
            parametersDictionary[WebRequestKeys.userId] = userId
            parametersDictionary.addValueIfNotNil(description, toKey: WebRequestKeys.description)
            return parametersDictionary
        }

        /// `convertGetStreamMarkersParamsToDict` is used to convert the typed parameters into a
        /// list of web request parameters as a String-keyed Dictionary for a `getStreamMarkers`
        /// method call.
        ///
        /// - Parameters:
        ///   - userId: input
        ///   - videoId: input
        ///   - after: input
        ///   - before: input
        ///   - first: input
        /// - Returns: The String-keyed `Dictionary` of parameters.
        private static func convertGetStreamMarkersParamsToDict(userId: String, videoId: String, after: String?,
                                                                before: String?, first: Int?) -> [String: Any] {
            var parametersDictionary = [String: Any]()
            parametersDictionary[WebRequestKeys.userId] = userId
            parametersDictionary[WebRequestKeys.videoId] = videoId
            parametersDictionary.addValueIfNotNil(after, toKey: WebRequestKeys.after)
            parametersDictionary.addValueIfNotNil(before, toKey: WebRequestKeys.before)
            parametersDictionary.addValueIfNotNil(first, toKey: WebRequestKeys.first)
            return parametersDictionary
        }
    }

    // MARK: - Users

    /// Users is a category of Twitch API calls used for getting data about users on Twitch.
    public struct Users {

        /// `GetUsersResult` defines the different types of results that can be retrieved from the
        /// `getUsers` call of the `Users` API. Variables are included that specify the data that
        /// was returned.
        ///
        /// - success: Defines that the call was successful. The output variable will contain all
        /// user data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetUsersResult {
            case success(GetUsersData)
            case failure(Data?, URLResponse?, Error?)
        }

        /// `GetUsersFollowsResult` defines the different types of results that can be retrieved
        /// from the `getUsersFollows` call of the `Users` API. Variables are included that specify
        /// the data that was returned on completion of this call.
        ///
        /// - success: Defines that the call was successful. The output variable will contain all
        /// user followings data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetUsersFollowsResult {
            case success(GetUsersFollowsData)
            case failure(Data?, URLResponse?, Error?)
        }

        /// `UpdateUserResult` defines the different types of results that can be retrieved from the
        /// `updateUser` call of the `Users` API. Variables are included that specify the data that
        /// was returned on completion of this call.
        ///
        /// - success: Defines that the call was successful. The output variable will contain all
        /// user data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum UpdateUserResult {
            case success(UpdateUserData)
            case failure(Data?, URLResponse?, Error?)
        }

        /// `GetUserExtensionsResult` defines the different types of results that can be retrieved
        /// from the `getUserExtensions` call of the `Users` API. Variables are included that
        /// specify the data that was returned on completion of this call.
        ///
        /// - success: Defines that the call was successful. The output variable will contain all
        /// user data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetUserExtensionsResult {
            case success(GetUserExtensionsData)
            case failure(Data?, URLResponse?, Error?)
        }

        /// `usersURL` is the URL that should be accessed for basic GET/POST calls that interact
        /// with users data.
        private static let usersURL = URL(string: "https://api.twitch.tv/helix/users")!

        /// `getUsersFollowsURL` is the URL that should be accessed for the `Get Users Follows` API
        /// call.
        private static let getUsersFollowsURL = URL(string: "https://api.twitch.tv/helix/users/follows")!

        /// `userExtensionsListURL` is the URL should be accessed for the `Get User Extensions` API
        /// call.
        private static let userExtensionsListURL = URL(string: "https://api.twitch.tv/helix/users/extensions/list")!

        /// `getUsers` will run the `Get Users` API call of the New Twitch API. You can use this API
        /// call to retrieve the ID, user type, broadcaster type, profile image, offline splash
        /// image, view count and username of any provided users. You can provide both User IDs and
        /// Login Names for this call to retrieve this information. If neither information is
        /// provided the user specified through the token will have their information retrieved.
        ///
        /// This API call has an optional authentication token with `user:read:email` permissions.
        /// If such a token is provided, you can retrieve the email of the Bearer token's holder as
        /// well from this API call.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/reference/#get-users)
        ///
        /// - Parameters:
        ///   - tokenManager: The TokenManager whose token should be used. Singleton by default.
        ///   - userIds: The IDs of the users to look up information for
        ///   - userLoginNames: The login names of the users to look up information for
        ///   - completionHandler: The function that should be run whenever the retrieval is
        /// successful. There are two types of `GetUsersResult`: `success` and `failure`.
        ///
        /// - seealso: `GetUsersResult`
        public static func getUsers(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                    userIds: [String]?, userLoginNames: [String]?,
                                    completionHandler: @escaping (GetUsersResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: usersURL, withHTTPMethod: URLRequest.RequestHeaderTypes.get,
                withQueryParameters: convertGetUsersParamsToDict(userLoginNames: userLoginNames, userIds: userIds),
                withBodyParameters: nil, enforcesAuthorization: true, withTokenManager: tokenManager,
                onSuccess: { completionHandler(GetUsersResult.success($0)) },
                onFailure: { completionHandler(GetUsersResult.failure($0, $1, $2)) })
        }

        /// `getUsersFollows` will run the `Get Users Follows` API call of the New Twitch API. You
        /// can use this API call to retrieve the number of followers a user has, the number of
        /// users they are following, or if a user is following another user.
        ///
        /// The results of this API call are paginated if the response is too large to fit into a
        /// single request.
        ///
        /// This API call requires no authentication.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/reference/#get-users-follows)
        ///
        /// - Parameters:
        ///   - tokenManager: The TokenManager whose token should be used. Singleton by default.
        ///   - followerId: The ID of the follower. Use this to get users this user is following.
        ///   - followedId: The ID of the user being followed. Use this to get the users that are
        /// following this user.
        ///   - after: The forward pagination token.
        ///   - first: The number of results to return. Default 20. Maximum 100.
        ///   - completionHandler: The function that should be run whenever the retrieval is
        /// successful. There are two types of `GetUsersFollowsResult`: `success` and `failure`.
        ///
        /// - seealso: `GetUsersFollowsResult`
        public static func getUsersFollows(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                           followerId: String?, followedId: String?, after: String? = nil,
                                           first: Int? = nil,
                                           completionHandler: @escaping (GetUsersFollowsResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: getUsersFollowsURL, withHTTPMethod: URLRequest.RequestHeaderTypes.get,
                withQueryParameters: convertGetUsersFollowsParamsToDict(followerId: followerId,
                                                                        followedId: followedId, after: after,
                                                                        first: first),
                withBodyParameters: nil, enforcesAuthorization: false, withTokenManager: tokenManager,
                onSuccess: { completionHandler(GetUsersFollowsResult.success($0)) },
                onFailure: { completionHandler(GetUsersFollowsResult.failure($0, $1, $2)) })
        }

        /// `updateUser` will run the `Update User` API call of the New Twitch API. You can use this
        /// API call to update the description of the user. No other methods are available at this
        /// moment.
        ///
        /// This API call requires a token with `user:edit` permissions.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/reference/#update-user)
        ///
        /// - Parameters:
        ///   - tokenManager: The TokenManager whose token should be used. Singleton by default.
        ///   - description: The description to set for the user.
        ///   - completionHandler: The function that should be run whenever the command is
        /// successful. There are two types of `UpdateUserResult`: `success` and `failure`.
        ///
        /// - seealso: `UpdateUserResult`
        public static func updateUser(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                      description: String?,
                                      completionHandler: @escaping (UpdateUserResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: usersURL, withHTTPMethod: URLRequest.RequestHeaderTypes.put,
                withQueryParameters: convertUpdateUserParamsToDict(description: description),
                withBodyParameters: nil, enforcesAuthorization: true, withTokenManager: tokenManager,
                onSuccess: { completionHandler(UpdateUserResult.success($0)) },
                onFailure: { completionHandler(UpdateUserResult.failure($0, $1, $2)) })
        }

        /// `getUserExtensions` will run the `Get User Extensions` API call of the New Twitch API.
        /// You can use this API call retrieve the extensions that the token-bearing user has.
        ///
        /// This API call requires a token with `user:read:broadcast` permissions.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/reference/#get-user-extensions)
        ///
        /// - Parameters:
        ///   - tokenManager: The TokenManager whose token should be used. Singleton by default.
        ///   - completionHandler: The function that should be run whenever the retrieval is
        /// successful. There are two types of `GetUserExtensionsResult`: `success` and `failure`.
        ///
        /// - seealso: `GetUserExtensionsResult`
        public static func getUserExtensions(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                             completionHandler: @escaping (GetUserExtensionsResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: userExtensionsListURL, withHTTPMethod: URLRequest.RequestHeaderTypes.get,
                withQueryParameters: nil, withBodyParameters: nil,
                enforcesAuthorization: true, withTokenManager: tokenManager,
                onSuccess: { completionHandler(GetUserExtensionsResult.success($0)) },
                onFailure: { completionHandler(GetUserExtensionsResult.failure($0, $1, $2)) })
        }

        /// `convertGetUsersParamsToDict` is used to convert the typed parameters into a list of web
        /// request parameters as a String-keyed Dictionary for a `getUsers` method call.
        ///
        /// - Parameters:
        ///   - userIds: input
        ///   - userLoginNames: input
        /// - Returns: The String-keyed `Dictionary` of parameters.
        private static func convertGetUsersParamsToDict(userLoginNames: [String]?,
                                                        userIds: [String]?) -> [String: Any] {
            var parametersDictionary = [String: Any]()
            parametersDictionary.addValueIfNotNil(userLoginNames, toKey: WebRequestKeys.login)
            parametersDictionary.addValueIfNotNil(userIds, toKey: WebRequestKeys.id)
            return parametersDictionary
        }

        /// `convertGetUsersFollowsParamsToDict` is used to convert the typed parameters into a list
        /// of web request parameters as a String-keyed Dictionary for a `getUsersFollows` method
        /// call.
        ///
        /// - Parameters:
        ///   - followerId: input
        ///   - followedId: input
        ///   - after: input
        ///   - first: input
        /// - Returns: The String-keyed `Dictionary` of parameters.
        private static func convertGetUsersFollowsParamsToDict(followerId: String?, followedId: String?,
                                                               after: String?, first: Int?) -> [String: Any] {
            var parametersDictionary = [String: Any]()
            parametersDictionary.addValueIfNotNil(followerId, toKey: WebRequestKeys.fromId)
            parametersDictionary.addValueIfNotNil(followedId, toKey: WebRequestKeys.toId)
            parametersDictionary.addValueIfNotNil(after, toKey: WebRequestKeys.after)
            parametersDictionary.addValueIfNotNil(first, toKey: WebRequestKeys.first)
            return parametersDictionary
        }

        /// `convertUpdateUserParamsToDict` is used to convert the typed parameters into a list of
        /// web request parameters as a String-keyed Dictionary for a `updateUser` method call.
        ///
        /// - Parameter description: input
        /// - Returns: The String-keyed `Dictionary` of parameters.
        private static func convertUpdateUserParamsToDict(description: String?) -> [String: Any] {
            var parametersDictionary = [String: Any]()
            parametersDictionary.addValueIfNotNil(description, toKey: Twitch.WebRequestKeys.description)
            return parametersDictionary
        }
    }

    /// Videos is a category of Twitch API calls that allow for the interaction of Video Data from
    /// the New Twitch API.
    public struct Videos {

        /// `Period` defines the different types of periods that are accepted by the Twitch API for
        /// use in retrieving Videos based on an amount of time.
        ///
        /// - all: Defines a period spanning since the beginning of time. Seriously.
        /// - day: Defines a period spanning all day.
        /// - week: Defines a period spanning all week.
        /// - month: Defines a period spanning all month.
        public enum Period: String {
            case all = "all"
            case day = "day"
            case week = "week"
            case month = "month"
        }

        /// `SortType` defines a type of sorting that can be used to retrieve videos from the
        /// `Get Videos` API call in a specific order.
        ///
        /// - time: Videos will be sorted by their time order. Most recent first.
        /// - trending: Videos will be sorted based on their "trending" status.
        /// - views: Videos will be sorted by their amount of views.
        public enum SortType: String {
            case time = "time"
            case trending = "trending"
            case views = "views"
        }

        /// `VideoQueryType` defines the types of videos that may be queried for. This enum is used
        /// in the `Get Videos` API call.
        ///
        /// - all: `all` applies no filter to results.
        /// - upload: `upload` applies a filter that only allows uploaded videos to be returned.
        /// - archive: `archive` applies a filter that allows only archived videos the be returned.
        /// - highlight: `highlight` applies a filter that allows only highlighted videos to be
        /// returned.
        public enum VideoQueryType: String {
            case all = "all"
            case upload = "upload"
            case archive = "archive"
            case highlight = "highlight"
        }

        /// `GetVideosResult` defines the different types of results that can be retrieved from the
        /// `getVideos` call of the `Videos` API. Variables are included that specify the data that
        /// was returned.
        ///
        /// - success: Defines that the call was successful. The output variable will contain all
        /// received data.
        /// - failure: Defines that the call failed. Returns all data corresponding to the failed
        /// call. These data pieces are as follows:
        /// 1. Data? - The data that was returned by the API
        /// 1. URLResponse? - The response from the URL task
        /// 1. Error? - The error that was returned from the API call
        public enum GetVideosResult {
            case success(GetVideosData)
            case failure(Data?, URLResponse?, Error?)
        }

        /// `videoURL` is the URL that should be accessed for base Video data calls.
        private static let videosURL = URL(string: "https://api.twitch.tv/helix/videos")!

        /// `getVideos` will run the `Get Videos` API call of the New Twitch API. This call will
        /// retrieve all video data in a paginated fashion. This video data can be sorted or
        /// filtered based on input parameters.
        ///
        /// This API call requires no authentication to use.
        ///
        /// [More information about the web call is available here](
        /// https://dev.twitch.tv/docs/api/reference/#get-videos)
        ///
        /// - Parameters:
        ///   - tokenManager: The TokenManager whose token should be used. Singleton by default.
        ///   - videoIds: The IDs of the video to be queried. Maximum 100. If this is specified,
        /// then no optional values can be used. Optional if `userId` or `gameId` is specified.
        ///   - userId: The ID of the user to query videos for. Optional if `videoIds` or `gameId`
        /// is specified.
        ///   - gameId: The ID of the game to query videos for. Optional if `videoIds` or `userId`
        /// is specified.
        ///   - after: The forward pagination token.
        ///   - before: The backwards pagination token.
        ///   - first: The maximum number of videos to return. Maximum: 100. Default: 20.
        ///   - language: The language videos must be in to be returned.
        ///   - period: The period to obtain data for. If this value is `.all`, Default: `.all`.
        ///   - sortType: The type of sorting that should occur. Default: `.time`.
        ///   - videoType: The type of videos that should be retrieved. Default: `.all`.
        ///   - completionHandler: The function that should be run whenever the retrieval is
        /// successful. There are two types of `GetVideosResultResult`: `success` and `failure`.
        ///
        /// - seealso: `Period`
        /// - seealso: `GetVideosResult`
        public static func getVideos(tokenManager: TwitchTokenManager = TwitchTokenManager.shared,
                                     videoIds: [String]?, userId: String?, gameId: String?,
                                     after: String? = nil, before: String? = nil, first: Int? = nil,
                                     language: String? = nil, period: Period? = nil,
                                     sortType: SortType? = nil, videoType: VideoQueryType? = nil,
                                     completionHandler: @escaping (GetVideosResult) -> Void) {
            Twitch.performAPIWebRequest(
                to: videosURL, withHTTPMethod: URLRequest.RequestHeaderTypes.get,
                withQueryParameters: convertGetVideosParamsToDict(videoIds: videoIds, userId: userId, gameId: gameId,
                                                                  after: after, before: before, first: first,
                                                                  language: language, period: period,
                                                                  sortType: sortType, videoType: videoType),
                withBodyParameters: nil, enforcesAuthorization: false, withTokenManager: tokenManager,
                onSuccess: { completionHandler(GetVideosResult.success($0)) },
                onFailure: { completionHandler(GetVideosResult.failure($0, $1, $2)) })
        }

        /// `convertGetVideosParamsToDict` is used to convert the typed parameters into a list of
        /// web request parameters as a String-keyed Dictionary for a `getVideos` method call.
        ///
        /// - Parameters:
        ///   - videoIds: input
        ///   - userId: input
        ///   - gameId: input
        ///   - after: input
        ///   - before: input
        ///   - first: input
        ///   - language: input
        ///   - period: input
        ///   - sortType: input
        ///   - videoType: input
        /// - Returns: The String-keyed `Dictionary` of parameters.
        private static func convertGetVideosParamsToDict(videoIds: [String]?, userId: String?,gameId: String?,
                                                         after: String?, before: String?, first: Int?,
                                                         language: String?, period: Period?, sortType: SortType?,
                                                         videoType: VideoQueryType?) -> [String: Any] {
            var parametersDictionary = [String: Any]()
            parametersDictionary.addValueIfNotNil(videoIds, toKey: WebRequestKeys.id)
            parametersDictionary.addValueIfNotNil(userId, toKey: WebRequestKeys.userId)
            parametersDictionary.addValueIfNotNil(gameId, toKey: WebRequestKeys.gameId)
            parametersDictionary.addValueIfNotNil(after, toKey: WebRequestKeys.after)
            parametersDictionary.addValueIfNotNil(before, toKey: WebRequestKeys.before)
            parametersDictionary.addValueIfNotNil(first, toKey: WebRequestKeys.first)
            parametersDictionary.addValueIfNotNil(language, toKey: WebRequestKeys.language)
            parametersDictionary.addValueIfNotNil(period?.rawValue, toKey: WebRequestKeys.period)
            parametersDictionary.addValueIfNotNil(sortType?.rawValue, toKey: WebRequestKeys.sort)
            parametersDictionary.addValueIfNotNil(videoType?.rawValue, toKey: WebRequestKeys.type)
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
    ///   - queryParameters: The query parameters of the web request
    ///   - bodyParameters: The body parameters of the web request
    ///   - enforcesAuthorization: If set to `true`, this will fail the API call if adding the
    /// authorization header fails. If `false`, the call will be ignored instead.
    ///   - tokenManager: The token manager that is used to provide authentication
    ///   - successHandler: The handler for a successful web request
    ///   - failureHandler: The handler for a failed web request
    private static func performAPIWebRequest<T: Unmarshaling>(
        to url: URL, withHTTPMethod httpMethod: String?, withQueryParameters queryParameters: [String: Any]?,
        withBodyParameters bodyParameters: [String: Any]?, enforcesAuthorization: Bool,
        withTokenManager tokenManager: TwitchTokenManager,
        onSuccess successHandler: @escaping (T) -> Void,
        onFailure failureHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {

        var request = URLRequest(url: queryParameters == nil ? url : url.withQueryItems(queryParameters!))
        do {
            try request.addTokenAuthorizationHeader(fromTokenManager: tokenManager)
        } catch {
            if enforcesAuthorization {
                failureHandler(nil, nil, error)
                return
            }
        }

        request.setValueToJSONContentType()
        request.httpMethod = httpMethod
        request.httpBody = bodyParameters?.getAsData()

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
