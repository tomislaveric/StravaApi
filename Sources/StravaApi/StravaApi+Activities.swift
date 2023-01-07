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
    
    public func getActivityKudos(by id: Int, page: Int?, perPage: Int?) async throws -> [Kudo] {
        guard let endpoint = URL(string: Endpoint.activity(id: id, subType: .kudos)) else {
            throw StravaApiError.badUrl
        }
        let params: KeyValuePairs<String, Any?> = [
            "page" : page,
            "per_page": perPage
        ]
        return try await handleRequest(url: endpoint, type: .GET, params: params)
    }
    
    public func getActivityComments(by id: Int, page: Int?, perPage: Int?, pageSize: Int?, afterCursor: String?) async throws -> [Comment] {
        guard let endpoint = URL(string: Endpoint.activity(id: id, subType: .comments)) else {
            throw StravaApiError.badUrl
        }
        
        let params: KeyValuePairs<String, Any?> = [
            "page" : page,
            "per_page": perPage,
            "page_size": pageSize,
            "after_cursor": afterCursor
        ]
        return try await handleRequest(url: endpoint, type: .GET, params: params)
    }
    
    public func getDetailedActivity(by id: Int, withEfforts: Bool?) async throws -> DetailedActivity {
        guard let endpoint = URL(string: Endpoint.activity(id: id)) else {
            throw StravaApiError.badUrl
        }
        let params: KeyValuePairs<String, Any?> = [
            "include_all_efforts": withEfforts
        ]
        return try await handleRequest(url: endpoint, type: .GET, params: params)
    }
    
    public func getAthleteDetailedActivities(before: Int?, after: Int?, page: Int?, perPage: Int?) async throws -> [DetailedActivity] {
        guard let endpoint = URL(string: Endpoint.athleteActivities) else {
            throw StravaApiError.badUrl
        }
        
        let params: KeyValuePairs<String, Any?> = [
            "before" : before,
            "after": after,
            "page": page,
            "per_page": perPage
        ]
        return try await handleRequest(url: endpoint, type: .GET, params: params)
    }
    
    public func createActivity(name: String, type: SportType, startDate: Date, elapsedTime: Int, description: String?, distance: Double?, trainer: Bool?, commute: Bool?) async throws -> DetailedActivity {
        guard let endpoint = URL(string: Endpoint.activity()) else {
            throw StravaApiError.badUrl
        }
        let params: KeyValuePairs<String, Any?> = [
            "name" : name,
            "sport_type": type.rawValue,
            "start_date_local": startDate.ISO8601Format(),
            "elapsed_time": elapsedTime,
            "description": description,
            "distance": distance,
            "trainer": trainer,
            "commute": commute
        ]
        return try await handleRequest(url: endpoint, type: .POST, params: params)
    }
}

extension StravaApi {
    // MARK: Default protocol implementations
    public func createActivity(name: String, type: SportType, startDate: Date, elapsedTime: Int, description: String? = nil, distance: Double? = nil, trainer: Bool? = nil, commute: Bool? = nil) async throws -> DetailedActivity {
        return try await self.createActivity(name: name, type: type, startDate: startDate, elapsedTime: elapsedTime, description: description, distance: distance, trainer: trainer, commute: commute)
    }
    
    public func getActivityComments(by id: Int, page: Int? = nil, perPage: Int? = nil, pageSize: Int? = nil, afterCursor: String? = nil) async throws -> [Comment] {
        return try await getActivityComments(by: id, page: page, perPage: perPage, pageSize: pageSize, afterCursor: afterCursor)
    }
    
    public func getDetailedActivity(by id: Int, withEfforts: Bool? = nil) async throws -> DetailedActivity {
        return try await getDetailedActivity(by: id, withEfforts: withEfforts)
    }
    
    public func getAthleteDetailedActivities(before: Int? = nil, after: Int? = nil, page: Int? = nil, perPage: Int? = nil) async throws -> [DetailedActivity] {
        return try await getAthleteDetailedActivities(before: before, after: after, page: page, perPage: perPage)
    }
    
    public func getActivityKudos(by id: Int) async throws -> [Kudo] {
        return try await getActivityKudos(by: id, page: nil, perPage: nil)
    }
}
