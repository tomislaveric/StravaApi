import HTTPRequest
import Foundation

public protocol StravaApi {
    func getProfile() async throws -> Athlete
    func getUserActivities() async throws -> [DetailedActivity]
}

public struct StravaApiImpl: StravaApi {
    public func getUserActivities() async throws -> [DetailedActivity] {
        guard let url = URL(string: "\(Endpoint.baseUrl.rawValue)\(Endpoint.athleteActivities.rawValue)") else {
            throw StravaApiError.badUrl
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        return try await session.get(request: urlRequest)
    }
    
    
    public func getProfile() async throws -> Athlete {
        guard let url = URL(string: "\(Endpoint.baseUrl.rawValue)\(Endpoint.athlete.rawValue)") else {
            throw StravaApiError.badUrl
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        return try await session.get(request: urlRequest)
    }
    
    private let token: String
    private let session: HTTPRequest
    
    public init(token: String, session: HTTPRequest = HTTPRequestImpl()) {
        self.token = token
        self.session = session
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
