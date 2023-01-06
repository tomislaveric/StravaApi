import Foundation

//  MARK: Protocol functions
/// Athlete related endpoint requests
extension StravaApiImpl {
    
    public func getAthleteZones() async throws -> [ActivityZone] {
        guard let endpoint = URL(string: Endpoint.athlete(subType: .zones)) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(url: endpoint)
    }
    
    
    public func getDetailedAthlete() async throws -> DetailedAthlete {
        guard let endpoint = URL(string: Endpoint.athlete()) else {
            throw StravaApiError.badUrl
        }
        return try await handleRequest(url: endpoint)
    }
}
