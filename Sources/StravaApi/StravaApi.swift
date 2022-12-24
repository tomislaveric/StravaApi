import HTTPRequest
import Foundation

public protocol StravaApi {
    func getProfile() async throws -> Athlete
}

public struct StravaApiImpl: StravaApi {

    public func getProfile() async throws -> Athlete {
        guard let url = URL(string: "\(Endpoint.activity.rawValue)") else {
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

public struct Athlete: Decodable, Equatable {
    public let username: String
}

enum Endpoint: String {
    case activity = "https://www.strava.com/api/v3/athlete"
}

enum StravaApiError: Error {
    case badUrl
}
