import HTTPRequest
import Foundation
import OAuth
import KeychainStorage

public protocol StravaApi {
    func getDetailedAthlete() async throws -> DetailedAthlete
    func getAthleteDetailedActivities(params: AthleteDetailedActivitiesParams?) async throws -> [DetailedActivity]
    func getDetailedActivity(by: Int, params: DetailedActivityParams?) async throws -> DetailedActivity
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
    
    public func getDetailedActivity(by id: Int, params: DetailedActivityParams?) async throws -> DetailedActivity {
        guard let endpoint = URL(string: Endpoint.activity(id: id)) else {
            throw StravaApiError.badUrl
        }
        var urlComponents = URLComponents(url: endpoint, resolvingAgainstBaseURL: true)
        if let params = params, params.includeAllEfforts {
            let queryItems = [URLQueryItem(name: "include_all_efforts", value: "\(params.includeAllEfforts)")]
            urlComponents?.queryItems = queryItems
        }
        
        return try await handleRequest(endpoint: urlComponents?.url)
    }
    
    public func getAthleteDetailedActivities(params: AthleteDetailedActivitiesParams?) async throws -> [DetailedActivity] {
        guard let endpoint = URL(string: Endpoint.athleteActivities) else {
            throw StravaApiError.badUrl
        }
        
        var urlComponents = URLComponents(url: endpoint, resolvingAgainstBaseURL: true)
        var queryItems: [URLQueryItem] = []
        if let params = params {
            if let before = params.before {
                queryItems.append(URLQueryItem(name: "before", value: "\(before)"))
            }
            if let after = params.after {
                queryItems.append(URLQueryItem(name: "after", value: "\(after)"))
            }
            if let page = params.page {
                queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
            }
            if let perPage = params.perPage {
                queryItems.append(URLQueryItem(name: "perPage", value: "\(perPage)"))
            }
            if !queryItems.isEmpty {
                urlComponents?.queryItems = queryItems
            }
        }
        return try await handleRequest(endpoint: urlComponents?.url)
    }
    
    public func getDetailedAthlete() async throws -> DetailedAthlete {
        guard let endpoint = URL(string: Endpoint.athlete()) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(endpoint: endpoint)
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
