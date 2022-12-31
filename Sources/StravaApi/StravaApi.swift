import HTTPRequest
import Foundation
import OAuth
import KeychainStorage

public protocol StravaApi {
    func getProfile() async throws -> Athlete
    func getUserActivities() async throws -> [DetailedActivity]
}

public class StravaApiImpl: StravaApi {
    private let storageName = Bundle.main.bundleIdentifier ?? "StravaApi"
    
    private func getSavedToken() throws -> Token? {
        guard let token: Token = try self.storage.read(name: storageName) else { return nil }
        return token
    }
    
    private func save(token: Token) throws {
        try self.storage.save(name: storageName, object: token)
    }
    
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
        if let token = try await oAuth.getAccessToken(currentToken: getSavedToken()) {
            //TODO: Save Token
            try save(token: token)
            let url = "\(token.token_type) \(token.access_token)"
            urlRequest.addValue(url, forHTTPHeaderField: "Authorization")
        }
        return try await request.get(request: urlRequest)
    }
    
    private let request: HTTPRequest
    private let oAuth: OAuth
    private let storage: KeychainStorage
    
    public init(config: StravaConfig, request: HTTPRequest = HTTPRequestImpl(), storage: KeychainStorage = KeychainStorageImpl()) {
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
        self.storage = storage
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
