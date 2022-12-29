import HTTPRequest
import Foundation

public protocol StravaApi {
    func getProfile(token: String?) async throws -> Athlete
    func getUserActivities(token: String?) async throws -> [DetailedActivity]
}

public struct StravaApiImpl: StravaApi {
    public func getUserActivities(token: String?) async throws -> [DetailedActivity] {
        guard let url = URL(string: "\(Endpoint.baseUrl.rawValue)\(Endpoint.athleteActivities.rawValue)") else {
            throw StravaApiError.badUrl
        }
        var urlRequest = URLRequest(url: url)
        if let token = token {
            urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        }
        return try await session.get(request: urlRequest)
    }
    
    
    public func getProfile(token: String?) async throws -> Athlete {
        guard let url = URL(string: "\(Endpoint.baseUrl.rawValue)\(Endpoint.athlete.rawValue)") else {
            throw StravaApiError.badUrl
        }
        var urlRequest = URLRequest(url: url)
        if let token = token {
            urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        }
        return try await session.get(request: urlRequest)
    }
    
    private let session: HTTPRequest
    
    public init(session: HTTPRequest = HTTPRequestImpl()) {
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
