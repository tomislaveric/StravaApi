import HTTPRequest
import Foundation
import OAuth
import KeychainStorage

public protocol StravaApi {
    func getDetailedAthlete() async throws -> DetailedAthlete
    func getAthleteDetailedActivities() async throws -> [DetailedActivity]
    func getDetailedActivity(by: Int) async throws -> DetailedActivity
}

public class StravaApiImpl: StravaApi {
    public func getDetailedActivity(by id: Int) async throws -> DetailedActivity {
        return try await handleRequest(endpoint: Endpoint.activity(id: id))
    }
    
    public func getAthleteDetailedActivities() async throws -> [DetailedActivity] {
        return try await handleRequest(endpoint: Endpoint.athleteActivities)
    }
    
    public func getDetailedAthlete() async throws -> DetailedAthlete {
        return try await handleRequest(endpoint: Endpoint.athlete())
    }
    
    private let storageName = Bundle.main.bundleIdentifier ?? "strava_api.oauth_token"
    private func getSavedToken() throws -> Token? {
        guard let token: Token = try self.storage.read(name: storageName) else { return nil }
        return token
    }
    
    private func save(token: Token) throws {
        try self.storage.save(name: storageName, object: token)
    }
    
    private func handleRequest<ReturnType: Decodable>(endpoint: String) async throws -> ReturnType {
        guard let url = URL(string: endpoint) else {
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

struct Endpoint {
    enum Subtype: String {
        case zones
        case streams
        case kudos
        case comments
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
