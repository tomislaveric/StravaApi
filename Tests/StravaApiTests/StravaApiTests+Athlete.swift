import XCTest
import HTTPRequest
import OAuth
@testable import StravaApi

extension StravaApiTests {
    func test_getAthleteShouldReturn_Athlete() async throws {
        let sut = try createSUT()
        try requestShouldReturn(for: "/api/v3/athlete", jsonFileName: "DetailedAthlete")
        
        let expectation = expectation(description: "Fetching /athlete")
        let actual: DetailedAthlete = try await sut.getDetailedAthlete()
        XCTAssertEqual(actual.username, "marianne_t")
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    func test_getAthleteZonesShouldReturn_Zones() async throws {
        let sut = try createSUT()
        try requestShouldReturn(for: "/api/v3/athlete/zones", jsonFileName: "Zones")
        
        let expectation = expectation(description: "Fetching /athlete")
        let actual: [ActivityZone] = try await sut.getAthleteZones()
        XCTAssertEqual(actual.count, 2)
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    func test_getAthleteStatsShouldReturn_ActivityStats() async throws {
        let sut = try createSUT()
        try requestShouldReturn(for: "/api/v3/athlete/12/stats", jsonFileName: "ActivityStats")
        
        let expectation = expectation(description: "Fetching /athlete")
        let actual: ActivityStats = try await sut.getAthleteStats(by: 12)
        XCTAssertEqual(actual.biggest_ride_distance, 127)
        XCTAssertEqual(actual.recent_ride_totals?.count, 2)
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
}
