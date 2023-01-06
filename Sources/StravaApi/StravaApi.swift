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
    func handleRequest<ReturnType: Decodable>(url: URL, params: KeyValuePairs<String, Any>? = nil) async throws -> ReturnType {
        return try await triggerRequest(endpoint: params == nil ? url : set(params: params, for: url))
    }
    
    private func triggerRequest<ReturnType: Decodable>(endpoint: URL?) async throws -> ReturnType {
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
    
    // MARK: Private helper functions
    private func set(params: KeyValuePairs<String, Any>?, for endpoint: URL) -> URL? {
        var urlComponents = URLComponents(url: endpoint, resolvingAgainstBaseURL: true)
        var queryItems: [URLQueryItem] = []
        params?.forEach { param in
            queryItems.append(URLQueryItem(name: "\(param.key)", value: "\(param.value)"))
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
