import Foundation

//  MARK: Protocol functions
/// Activities related endpoint requests
extension StravaApiImpl {
    
    public func getActivityZones(by id: Int) async throws -> [ActivityZone] {
        guard let endpoint = URL(string: Endpoint.activity(id: id, subType: .zones)) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(url: endpoint, type: .GET)
    }
    
    public func getActivityLaps(by id: Int) async throws -> [Lap] {
        guard let endpoint = URL(string: Endpoint.activity(id: id, subType: .laps)) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(url: endpoint, type: .GET)
    }
    
    public func getDetailedActivity(by id: Int, params: KeyValuePairs<String, Any>?) async throws -> DetailedActivity {
        guard let endpoint = URL(string: Endpoint.activity(id: id)) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(url: endpoint, type: .GET, params: params)
    }
    
    public func getAthleteDetailedActivities(params: KeyValuePairs<String, Any>?) async throws -> [DetailedActivity] {
        guard let endpoint = URL(string: Endpoint.athleteActivities) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(url: endpoint, type: .GET, params: params)
    }
    
    public func getActivityComments(by id: Int) async throws -> [Comment] {
        guard let endpoint = URL(string: Endpoint.activity(id: id, subType: .comments)) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(url: endpoint, type: .GET)
    }
    
    public func getActivityKudos(by id: Int) async throws -> [Kudo] {
        guard let endpoint = URL(string: Endpoint.activity(id: id, subType: .kudos)) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(url: endpoint, type: .GET)
    }
    
    public func createActivity(name: String, type: SportType, startDate: Date, elapsedTime: Int, description: String? = nil, distance: Double? = nil, trainer: Bool? = nil, commute: Bool? = nil) async throws -> DetailedActivity {
        guard let endpoint = URL(string: Endpoint.activity()) else {
            throw StravaApiError.badUrl
        }
        let params: KeyValuePairs<String, Any> = [
            "name" : name,
            "sport_type": type.rawValue,
            "start_date_local": startDate.ISO8601Format(),
            "elapsed_time": elapsedTime,
            "description": {},
            "distance": distance ?? {},
            "trainer": trainer ?? {},
            "commute": commute ?? {}
        ]
        
        return try await handleRequest(url: endpoint, type: .POST, params: params)
    }
    /// Default implementation of ``createActivity(name:type:startDate:elapsedTime:description:distance:trainer:commute:)``
    public func createActivity(name: String, type: SportType, startDate: Date, elapsedTime: Int) async throws -> DetailedActivity {
        return try await self.createActivity(name: name, type: type, startDate: startDate, elapsedTime: elapsedTime)
    }
}
