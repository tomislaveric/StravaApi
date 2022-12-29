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
        return try await request.get(request: urlRequest)
    }
    
    private let request: HTTPRequest
    private let oAuth: OAuth
    
    public init(config: StravaConfig, request: HTTPRequest = HTTPRequestImpl()) {
        let oAuthConfig = OAuthConfig(
            authorizeUrl: config.authorizeUrl,
            tokenUrl: config.tokenUrl,
            clientId: config.clientId,
            redirectUri: config.redirectUri,
            callbackURLScheme: config.callbackURLScheme,
            clientSecret: config.clientSecret,
            responseType: config.responseType,
            approvalPrompt: config.approvalPrompt,
            scope: config.scope.joined(separator: ","),
            authorizationGrant: config.authorizationGrant,
            refreshGrant: config.refreshGrant
        )
        self.request = request
        self.oAuth = OAuthImpl(config: oAuthConfig)
    }
}

enum Endpoint: String {
    case baseUrl = "https://www.strava.com/api/v3"
    case athlete = "/athlete"
    case athleteActivities = "/athlete/activities"
}

enum StravaApiError: Error {
    case badUrl
}
