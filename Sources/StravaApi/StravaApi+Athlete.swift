import Foundation

//  MARK: Protocol functions
/// Athlete related endpoint requests
extension StravaApiImpl {
    
    public func getAthleteZones() async throws -> Zones {
        guard let endpoint = URL(string: Endpoint.athlete(subType: .zones)) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(url: endpoint, type: .GET)
    }
    
    
    public func getDetailedAthlete() async throws -> DetailedAthlete {
        guard let endpoint = URL(string: Endpoint.athlete()) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(url: endpoint, type: .GET)
    }
    
    public func getAthleteStats(by id: Int) async throws -> ActivityStats {
        guard let endpoint = URL(string: Endpoint.athlete(id: id, subType: .stats)) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(url: endpoint, type: .GET)
    }
}
