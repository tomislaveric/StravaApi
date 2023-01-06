import HTTPRequest
import Foundation
import OAuth

public protocol StravaApi {
    func registerTokenUpdate(current: Token?, callback: @escaping (Token) throws -> Void)
    func getDetailedAthlete() async throws -> DetailedAthlete
    func getAthleteDetailedActivities(params: KeyValuePairs<String, Any>?) async throws -> [DetailedActivity]
    func getDetailedActivity(by: Int, params: KeyValuePairs<String, Any>?) async throws -> DetailedActivity
    func getActivityZones(by: Int) async throws -> [ActivityZone]
    func getActivityLaps(by: Int) async throws -> [Lap]
}

public class StravaApiImpl: StravaApi {
    public func registerTokenUpdate(current: Token?, callback: @escaping (Token) throws -> Void) {
        self.currentToken = current
        self.callback = callback
    }
    
    private var currentToken: Token?
    private var callback: (Token) throws -> Void = { _ in }

    // MARK: Protocol functions
    public func getActivityZones(by id: Int) async throws -> [ActivityZone] {
        guard let endpoint = URL(string: Endpoint.activity(id: id, subType: .zones)) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(endpoint: endpoint)
    }
    
    public func getActivityLaps(by id: Int) async throws -> [Lap] {
        guard let endpoint = URL(string: Endpoint.activity(id: id, subType: .laps)) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(endpoint: endpoint)
    }
    
    public func getDetailedActivity(by id: Int, params: KeyValuePairs<String, Any>?) async throws -> DetailedActivity {
        guard let endpoint = URL(string: Endpoint.activity(id: id)) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequestForParamRequests(url: endpoint, params: params)
    }
    
    public func getAthleteDetailedActivities(params: KeyValuePairs<String, Any>?) async throws -> [DetailedActivity] {
        guard let endpoint = URL(string: Endpoint.athleteActivities) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequestForParamRequests(url: endpoint, params: params)
    }
    
    public func getDetailedAthlete() async throws -> DetailedAthlete {
        guard let endpoint = URL(string: Endpoint.athlete()) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(endpoint: endpoint)
    }
    
    // MARK: Private functions
    
    private func handleRequestForParamRequests<ReturnType: Decodable>(url: URL, params: KeyValuePairs<String, Any>?) async throws -> ReturnType {
       
        if params == nil {
            return try await handleRequest(endpoint: url)
        }
        return try await handleRequest(endpoint: set(params: params, for: url))
    }
    
    private func set(params: KeyValuePairs<String, Any>?, for endpoint: URL) -> URL? {
        var urlComponents = URLComponents(url: endpoint, resolvingAgainstBaseURL: true)
        var queryItems: [URLQueryItem] = []
        params?.forEach { param in
            queryItems.append(URLQueryItem(name: "\(param.key)", value: "\(param.value)"))
        }
        urlComponents?.queryItems = !queryItems.isEmpty ? queryItems : nil
        return urlComponents?.url
    }
    
    private func getSavedToken() throws -> Token? {
        guard let token = currentToken else { return nil }
        return token
    }
    
    private func handleRequest<ReturnType: Decodable>(endpoint: URL?) async throws -> ReturnType {
        guard let url = endpoint else {
            throw StravaApiError.badUrl
        }
        
        guard let token = try await getAccessToken() else {
            throw StravaApiError.couldNotFetchAccessToken
        }
        try callback(token)
        self.currentToken = token
        return try await request.get(url: url, header: ["Authorization": "\(token.token_type) \(token.access_token)"])
    }
    
    private func getAccessToken() async throws -> Token? {
        if let currentToken = try getSavedToken(), isValid(expiresAt: currentToken.expires_at) {
            return currentToken
        } else if let currentToken = try getSavedToken(), let refreshUrl = buildRefreshTokenUrl(from: currentToken) {
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
    
    // MARK: Initializer and Properties
    
    private let request: HTTPRequest
    private let oAuth: OAuth
    let config: StravaConfig
    
    public init(config: StravaConfig, oAuthClient: OAuth, request: HTTPRequest = HTTPRequestImpl()) {
        self.config = config
        self.request = request
        self.oAuth = oAuthClient
    }
}

public struct StravaConfig {
    public init(
        authorizeUrl: String,
        tokenUrl: String,
        clientId: String,
        redirectUri: String,
        callbackURLScheme: String,
        clientSecret: String,
        scope: String
    ) {
        self.authorizeUrl = authorizeUrl
        self.tokenUrl = tokenUrl
        self.clientId = clientId
        self.redirectUri = redirectUri
        self.callbackURLScheme = callbackURLScheme
        self.clientSecret = clientSecret
        self.scope = scope
    }
    
    public let authorizeUrl: String
    public let tokenUrl: String
    public let clientId: String
    public let redirectUri: String
    public let callbackURLScheme: String
    public let clientSecret: String
    public let scope: String
    public let responseType: String = "code"
    public let approvalPrompt: String = "auto"
    public let authorizationGrant: String = "authorization_code"
    public let refreshGrant: String = "refresh_token"
}

struct Endpoint {
    enum Subtype: String {
        case zones
        case streams
        case kudos
        case comments
        case laps
    }
    
    static let baseUrl = "https://www.strava.com/api/v3"
    static var athleteActivities: String {
        "\(self.baseUrl)/athlete/activities"
    }
    static func athlete() -> String {
        "\(self.baseUrl)/athlete"
    }
    static func activity(id: Int, subType: Subtype? = nil) -> String {
        if let type = subType {
            return "\(self.baseUrl)/activities/\(id)/\(type.rawValue)"
        } else {
            return "\(self.baseUrl)/activities/\(id)"
        }
    }
}

enum StravaApiError: Error {
    case badUrl
    case couldNotFetchAccessToken
}
