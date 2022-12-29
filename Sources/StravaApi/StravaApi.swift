import HTTPRequest
import Foundation
import OAuth

public protocol StravaApi {
    func getProfile() async throws -> Athlete
    func getUserActivities() async throws -> [DetailedActivity]
}

public struct StravaApiImpl: StravaApi {
    
    public func getUserActivities() async throws -> [DetailedActivity] {
        return try await handleRequest(endpoint: Endpoint.athleteActivities)
    }
    
    public func getProfile() async throws -> Athlete {
        return try await handleRequest(endpoint: Endpoint.athlete)
    }
    
    private func handleRequest<ReturnType: Decodable>(endpoint: Endpoint) async throws -> ReturnType {
        guard let url = URL(string: "\(Endpoint.baseUrl.rawValue)\(endpoint.rawValue)") else {
            throw StravaApiError.badUrl
        }
        var urlRequest = URLRequest(url: url)
        if let token = try await oAuth.getAccessToken() {
            urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        }
        return try await session.get(request: urlRequest)
    }
    
    private let session: HTTPRequest
    private let oAuth: OAuth
    
    public init(config: StravaConfig) {
        let oAuthConfig = OAuthConfig(
            authorizeUrl: config.authorizeUrl,
            tokenUrl: config.tokenUrl,
            clientId: config.clientId,
            redirectUri: config.redirectUri,
            callbackURLScheme: config.callbackURLScheme,
            clientSecret: config.clientSecret,
            scope: config.scope.joined(separator: ","))
        
        oAuth = OAuthImpl(config: oAuthConfig)
        session = HTTPRequestImpl()
    }
}

public struct StravaConfig {
    public init(authorizeUrl: String, tokenUrl: String, clientId: String, redirectUri: String, callbackURLScheme: String, clientSecret: String, scope: [String]) {
        self.authorizeUrl = authorizeUrl
        self.tokenUrl = tokenUrl
        self.clientId = clientId
        self.redirectUri = redirectUri
        self.callbackURLScheme = callbackURLScheme
        self.clientSecret = clientSecret
        self.scope = scope
    }
    
    public enum GrantType: String {
        case authorizationCode = "authorization_code"
        case refreshToken = "refresh_token"
    }
    
    public let authorizeUrl: String
    public let tokenUrl: String
    public let clientId: String
    public let redirectUri: String
    public let callbackURLScheme: String
    public let clientSecret: String
    public let responseType: String = "code"
    public let approvalPrompt: String = "auto"
    public let grantType: GrantType = .authorizationCode
    public let scope: [String]
}

enum Endpoint: String {
    case baseUrl = "https://www.strava.com/api/v3"
    case athlete = "/athlete"
    case athleteActivities = "/athlete/activities"
}

enum StravaApiError: Error {
    case badUrl
}
