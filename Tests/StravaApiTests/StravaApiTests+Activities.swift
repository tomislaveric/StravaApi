import XCTest
import HTTPRequest
import OAuth
@testable import StravaApi

extension StravaApiTests {
    func test_getAthleteDetailedActivities_shouldReturnDetailedActivities() async throws {
        let sut = try createSUT()
        try requestShouldReturn(for: "/api/v3/athlete/activities", jsonFileName: "DetailedActivities")
        
        let expectation = expectation(description: "Fetching activities")
        let actual: [DetailedActivity] = try await sut.getAthleteDetailedActivities()
        XCTAssertEqual(actual.count, 2)
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    func test_getAthleteDetailedActivities_shouldHaveCorrectParams() async throws {
        let sut = try createSUT()
        try requestShouldReturn(for: "/api/v3/athlete/activities?before=12&after=10&page=1&per_page=20", jsonFileName: "DetailedActivities")
        
        let expectation = expectation(description: "Fetching activities")
        let actual: [DetailedActivity] = try await sut.getAthleteDetailedActivities(before: 12, after: 10, page: 1, perPage: 20)
        XCTAssertEqual(actual.count, 2)
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    func test_getDetailedActivity_shouldReturnActivity() async throws {
        let sut = try createSUT()
        let activityId = 123
        try requestShouldReturn(for: "/api/v3/activities/\(activityId)", jsonFileName: "DetailedActivity")
        
        let expectation = expectation(description: "Fetching activity with id: \(activityId)")
        let actual: DetailedActivity = try await sut.getDetailedActivity(by: activityId)
        XCTAssertEqual(actual.id, activityId)
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    func test_getDetailedActivity_shouldHaveCorrectParams() async throws {
        let sut = try createSUT()
        let activityId = 123
        try requestShouldReturn(for: "/api/v3/activities/\(activityId)?include_all_efforts=true", jsonFileName: "DetailedActivity")
        
        let expectation = expectation(description: "Fetching activity with id: \(activityId)")
        let actual: DetailedActivity = try await sut.getDetailedActivity(by: activityId, withEfforts: true)
        XCTAssertEqual(actual.id, activityId)
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    func test_getActivityZones_shouldReturnActivityZone() async throws {
        let sut = try createSUT()
        let activityId = 8325454120
        try requestShouldReturn(for: "/api/v3/activities/\(activityId)/zones", jsonFileName: "Zones")
        
        let expectation = expectation(description: "Fetching activity zones with id: \(activityId)")
        let actual: [ActivityZone] = try await sut.getActivityZones(by: activityId)
        XCTAssertEqual(actual.count, 2)
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    func test_getActivityLaps_shouldReturnActivityZone() async throws {
        let sut = try createSUT()
        let activityId = 8325454120
        try requestShouldReturn(for: "/api/v3/activities/\(activityId)/laps", jsonFileName: "Laps")
        
        let expectation = expectation(description: "Fetching activity zones with id: \(activityId)")
        let actual: [Lap] = try await sut.getActivityLaps(by: activityId)
        XCTAssertEqual(actual.first?.id, 11)
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    func test_getActivityComments_shouldReturnComments() async throws {
        let sut = try createSUT()
        let activityId = 8325454120
        try requestShouldReturn(for: "/api/v3/activities/\(activityId)/comments", jsonFileName: "Comments")
        
        let expectation = expectation(description: "Fetching activity comments with id: \(activityId)")
        let actual: [Comment] = try await sut.getActivityComments(by: activityId)
        XCTAssertEqual(actual.first?.id, 12345678987654320)
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    func test_getActivityKudos_shouldReturnKudos() async throws {
        let sut = try createSUT()
        let activityId = 8325454120
        try requestShouldReturn(for: "/api/v3/activities/\(activityId)/kudos", jsonFileName: "Kudos")
        
        let expectation = expectation(description: "Fetching activity comments with id: \(activityId)")
        let actual: [Kudo] = try await sut.getActivityKudos(by: activityId)
        XCTAssertEqual(actual.count, 1)
        XCTAssertEqual(actual.first?.firstname, "Peter")
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
}
