import HTTPRequest
import Foundation
import OAuth
import KeychainStorage

public protocol StravaApi {
    func getDetailedAthlete() async throws -> DetailedAthlete
    func getAthleteDetailedActivities(params: KeyValuePairs<String, Any>?) async throws -> [DetailedActivity]
    func getDetailedActivity(by: Int, params: KeyValuePairs<String, Any>?) async throws -> DetailedActivity
    func getActivityZones(by: Int) async throws -> [ActivityZone]
    func getActivityLaps(by: Int) async throws -> [Lap]
}

public class StravaApiImpl: StravaApi {
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
    
    private let storageName = Bundle.main.bundleIdentifier ?? "strava_api.oauth_token"
    private func getSavedToken() throws -> Token? {
        guard let token: Token = try self.storage.read(name: storageName) else { return nil }
        return token
    }
    
    private func save(token: Token) throws {
        try self.storage.save(name: storageName, object: token)
    }
    
    private func handleRequest<ReturnType: Decodable>(endpoint: URL?) async throws -> ReturnType {
        guard let url = endpoint else {
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
