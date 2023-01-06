import Foundation

//  MARK: Protocol functions
/// Activities related endpoint requests
extension StravaApiImpl {
    
    public func getActivityZones(by id: Int) async throws -> [ActivityZone] {
        guard let endpoint = URL(string: Endpoint.activity(id: id, subType: .zones)) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(url: endpoint)
    }
    
    public func getActivityLaps(by id: Int) async throws -> [Lap] {
        guard let endpoint = URL(string: Endpoint.activity(id: id, subType: .laps)) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(url: endpoint)
    }
    
    public func getDetailedActivity(by id: Int, params: KeyValuePairs<String, Any>?) async throws -> DetailedActivity {
        guard let endpoint = URL(string: Endpoint.activity(id: id)) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(url: endpoint, params: params)
    }
    
    public func getAthleteDetailedActivities(params: KeyValuePairs<String, Any>?) async throws -> [DetailedActivity] {
        guard let endpoint = URL(string: Endpoint.athleteActivities) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(url: endpoint, params: params)
    }
    
    public func getActivityComments(by id: Int) async throws -> [Lap] {
        guard let endpoint = URL(string: Endpoint.activity(id: id, subType: .comments)) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(url: endpoint)
    }
}
