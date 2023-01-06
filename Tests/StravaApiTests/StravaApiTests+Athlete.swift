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
}
