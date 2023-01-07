import HTTPRequest
import Foundation
import OAuth

public protocol StravaApi {
    func registerTokenUpdate(current: Token?, callback: @escaping (Token) throws -> Void)
    /// Returns the currently authenticated athlete. Tokens with profile:read_all scope will receive a detailed athlete representation; all others will receive a summary representation.
    /// - Parameters:
    ///   - current:    The optional existing token of type ``Token``. If you have a persisted token, pass it within this function.
    ///   - callback:   This callback will be triggered if a new token was fetched, use this to persist the token of type ``Token``
    /// - Returns:      Type of ``DetailedAthlete``
    func getDetailedAthlete() async throws -> DetailedAthlete
    /// Returns the the authenticated athlete's heart rate and power zones. Requires profile:read_all.
    /// - Returns:      Array of ``ActivityZone``
    func getAthleteZones() async throws -> [ActivityZone]
    /// Returns the activities of an athlete for a specific identifier. Requires activity:read. Only Me activities will be filtered out unless requested by a token with activity:read_all.
    /// - Parameters:
    ///   - before:     An epoch timestamp to use for filtering activities that have taken place before a certain time.
    ///   - after:      An epoch timestamp to use for filtering activities that have taken place after a certain time.
    ///   - page:       Page number. Defaults to 1.
    ///   - perPage:    Number of items per page. Defaults to 30.
    /// - Returns:      Array of ``DetailedActivity``
    func getAthleteDetailedActivities(before: Int?, after: Int?, page: Int?, perPage: Int?) async throws -> [DetailedActivity]
    /// Returns the given activity that is owned by the authenticated athlete. Requires activity:read for Everyone and Followers activities. Requires activity:read_all for Only Me activities.
    /// - Parameters:
    ///   - id:         The identifier of the activity. (**required**)
    ///   - withEfforts:To include all segments efforts.
    /// - Returns:      Type of ``DetailedActivity``
    func getDetailedActivity(by: Int, withEfforts: Bool?) async throws -> DetailedActivity
    /// Summit Feature. Returns the zones of a given activity. Requires activity:read for Everyone and Followers activities. Requires activity:read_all for Only Me activities.
    /// - Parameters:
    ///   - id:         The identifier of the activity. (**required**)
    /// - Returns:      Array of ``ActivityZone``
    func getActivityZones(by: Int) async throws -> [ActivityZone]
    /// Returns the laps of an activity identified by an identifier. Requires activity:read for Everyone and Followers activities. Requires activity:read_all for Only Me activities.
    /// - Parameters:
    ///   - id:     The identifier of the activity. (**required**)
    /// - Returns:      Array of ``Lap``
    func getActivityLaps(by: Int) async throws -> [Lap]
    /// Returns the comments on the given activity. Requires activity:read for Everyone and Followers activities. Requires activity:read_all for Only Me activities.
    /// - Parameters:
    ///   - id:         The identifier of the activity. (**required**)
    ///   - perPage:    Number of items per page. Defaults to 30.
    ///   - pageSize:   Number of items per page. Defaults to 30.
    ///   - afterCursor:Cursor of the last item in the previous page of results, used to request the subsequent page of results. When omitted, the first page of results is fetched.
    /// - Returns:      Array of ``Comment``
    func getActivityComments(by: Int, page: Int?, perPage: Int?, pageSize: Int?, afterCursor: String?) async throws -> [Comment]
    /// Returns the athletes who kudoed an activity identified by an identifier. Requires activity:read for Everyone and Followers activities. Requires activity:read_all for Only Me activities.
    /// - Parameters:
    ///   - id:         The identifier of the activity. (**required**)
    ///   - page:       Page number. Defaults to 1.
    ///   - perPage:    Number of items per page. Defaults to 30.
    /// - Returns:      Array of ``Kudo``
    func getActivityKudos(by: Int, page: Int?, perPage: Int?) async throws -> [Kudo]
    /// Returns the activity stats of an athlete. Only includes data from activities set to Everyone visibilty.
    /// - Parameters:
    ///  - id:           The identifier of the athlete. Must match the authenticated athlete. (**required**)
    /// - Returns:      Type of ``ActivityStats``
    func getAthleteStats(by: Int) async throws -> ActivityStats
       /// Creates a manual activity for an athlete, requires activity:write scope.
       /// - Parameters:
       ///  - name:        The name of the activity.  (**required**)
       ///  - type:        The ``SportType``) of activity. (**required**)
       ///  - startDate:   Start date of activity. (**required**)
       ///  - elapsedTime: In seconds. (**required**)
       ///  - description: Description of activity.
       ///  - distance:    In meters.
       ///  - trainer:     Set true to mark as a trainer activity.
       ///  - commute:     Set true to mark as commute.
       /// - Returns:      Type of ``DetailedActivity``
    func createActivity(name: String, type: SportType, startDate: Date, elapsedTime: Int, description: String?, distance: Double?, trainer: Bool?, commute: Bool?) async throws -> DetailedActivity
}

public class StravaApiImpl: StravaApi {

    // MARK: Initializer and Properties
    private let request: HTTPRequest
    private let oAuth: OAuth
    private var currentToken: Token?
    private var callback: (Token) throws -> Void = { _ in }
    let config: StravaConfig
    
    public init(config: StravaConfig, oAuthClient: OAuth, request: HTTPRequest = HTTPRequestImpl()) {
        self.config = config
        self.request = request
        self.oAuth = oAuthClient
    }
    
    public func registerTokenUpdate(current: Token?, callback: @escaping (Token) throws -> Void) {
        self.currentToken = current
        self.callback = callback
    }
    
    // MARK: Helper functions
    func handleRequest<ReturnType: Decodable>(url: URL, type: RequestType, params: KeyValuePairs<String, Any?>? = nil) async throws -> ReturnType {
        return try await triggerRequest(endpoint: params == nil ? url : set(params: params, for: url), requestType: type)
    }
    
    private func triggerRequest<ReturnType: Decodable>(endpoint: URL?, requestType: RequestType) async throws -> ReturnType {
        guard let url = endpoint else {
            throw StravaApiError.badUrl
        }
        
        guard let token = try await getAccessToken() else {
            throw StravaApiError.couldNotFetchAccessToken
        }
        try callback(token)
        self.currentToken = token
        
        switch requestType {
        case .GET:
            return try await request.get(url: url, header: ["Authorization": "\(token.token_type) \(token.access_token)"])
        case .POST:
            return try await request.post(url: url, header: ["Authorization": "\(token.token_type) \(token.access_token)"])
        }
    }
    
    // MARK: Private helper functions
    private func set(params: KeyValuePairs<String, Any?>?, for endpoint: URL) -> URL? {
        var urlComponents = URLComponents(url: endpoint, resolvingAgainstBaseURL: true)
        var queryItems: [URLQueryItem] = []
        params?.forEach { param in
            if let value = param.value {
                queryItems.append(URLQueryItem(name: "\(param.key)", value: "\(value)"))
            }
        }
        urlComponents?.queryItems = !queryItems.isEmpty ? queryItems : nil
        return urlComponents?.url
    }
    
    private func getAccessToken() async throws -> Token? {
        if let currentToken = currentToken, isValid(expiresAt: currentToken.expires_at) {
            return currentToken
        } else if let currentToken = currentToken, let refreshUrl = buildRefreshTokenUrl(from: currentToken) {
            return try await oAuth.refreshToken(refreshUrl: refreshUrl)
        } else {
            guard let authUrl = buildAuthUrl(from: self.config) else { return nil }
            let authResponse = try await oAuth.authorize(authUrl: authUrl)
            let accessUrl = buildAccessTokenUrl(from: authResponse)
            return try await oAuth.getAccessToken(currentToken: nil, accessUrl: accessUrl)
        }
    }
    
    private func isValid(expiresAt: Double) -> Bool {
        return Date().timeIntervalSince1970 < expiresAt
    }
}

enum StravaApiError: Error {
    case badUrl
    case couldNotFetchAccessToken
}

enum RequestType {
    case GET
    case POST
}
