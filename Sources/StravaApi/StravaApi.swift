import HTTPRequest
import Foundation
import OAuth
import KeychainStorage

public protocol StravaApi {
    func getProfile() async throws -> DetailedAthlete
    func getUserActivities() async throws -> [DetailedActivity]
}

public class StravaApiImpl: StravaApi {
    private let storageName = Bundle.main.bundleIdentifier ?? "strava_api.oauth_token"
    
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
    
    public func getProfile() async throws -> DetailedAthlete {
        return try await handleRequest(endpoint: Endpoint.athlete)
    }
    
    private func handleRequest<ReturnType: Decodable>(endpoint: Endpoint) async throws -> ReturnType {
        guard let url = URL(string: "\(Endpoint.baseUrl.rawValue)\(endpoint.rawValue)") else {
            throw StravaApiError.badUrl
        }
        
        guard let token = try await oAuth.getAccessToken(currentToken: getSavedToken()) else {
            throw StravaApiError.couldNotFetchAccessToken
        }
        try save(token: token)
        return try await request.get(url: url, header: ["Authorization": "\(token.token_type) \(token.access_token)"])
    }
    
    private let request: HTTPRequest
    private let oAuth: OAuth
    private let storage: KeychainStorage
    
    public init(oAuthClient: OAuth,
                request: HTTPRequest = HTTPRequestImpl(),
                storage: KeychainStorage = KeychainStorageImpl())
    {
        self.request = request
        self.oAuth = oAuthClient
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
    case couldNotFetchAccessToken
}
