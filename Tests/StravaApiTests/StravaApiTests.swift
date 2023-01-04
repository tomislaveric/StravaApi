import XCTest
import HTTPRequest
import OAuth
@testable import StravaApi

final class StravaApiTests: XCTestCase {
    
    func test_getAthleteShouldReturn_Athlete() async throws {
        let sut = StravaApiImpl(
            oAuthClient: OAuthMock(),
            request: setupNetworkManager()
        )
        
        try requestShouldReturn(for: "/api/v3/athlete", jsonFileName: "DetailedAthlete")
        
        let expectation = expectation(description: "Fetching /athlete")
        let actual: DetailedAthlete = try await sut.getDetailedAthlete()
        XCTAssertEqual(actual.username, "marianne_t")
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    func test_getAthleteDetailedActivities_shouldReturnDetailedActivities() async throws {
        let sut = StravaApiImpl(
            oAuthClient: OAuthMock(),
            request: setupNetworkManager()
        )
        
        try requestShouldReturn(for: "/api/v3/athlete/activities", jsonFileName: "DetailedActivities")
        
        let expectation = expectation(description: "Fetching activities")
        let params = AthleteDetailedActivitiesParams()
        let actual: [DetailedActivity] = try await sut.getAthleteDetailedActivities(params: params)
        XCTAssertEqual(actual.count, 2)
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    func test_getAthleteDetailedActivities_shouldHaveCorrectParams() async throws {
        let sut = StravaApiImpl(
            oAuthClient: OAuthMock(),
            request: setupNetworkManager()
        )
        
        try requestShouldReturn(for: "/api/v3/athlete/activities?before=12&after=10&page=1&perPage=20", jsonFileName: "DetailedActivities")
        
        let expectation = expectation(description: "Fetching activities")
        let params = AthleteDetailedActivitiesParams(before: 12, after: 10, page: 1, perPage: 20)
        let actual: [DetailedActivity] = try await sut.getAthleteDetailedActivities(params: params)
        XCTAssertEqual(actual.count, 2)
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    func test_getDetailedActivity_shouldReturnActivity() async throws {
        let sut = StravaApiImpl(
            oAuthClient: OAuthMock(),
            request: setupNetworkManager()
        )
        let activityId = 8325454120
        try requestShouldReturn(for: "/api/v3/activities/\(activityId)", jsonFileName: "DetailedActivity")
        
        let expectation = expectation(description: "Fetching activity with id: \(activityId)")
        let params = DetailedActivityParams()
        let actual: DetailedActivity = try await sut.getDetailedActivity(by: activityId, params: params)
        XCTAssertEqual(actual.id, activityId)
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    func test_getDetailedActivity_shouldHaveCorrectParams() async throws {
        let sut = StravaApiImpl(
            oAuthClient: OAuthMock(),
            request: setupNetworkManager()
        )
        let activityId = 8325454120
        try requestShouldReturn(for: "/api/v3/activities/\(activityId)?include_all_efforts=true", jsonFileName: "DetailedActivity")
        
        let expectation = expectation(description: "Fetching activity with id: \(activityId)")
        let params = DetailedActivityParams(incldueAllEfforts: true)
        let actual: DetailedActivity = try await sut.getDetailedActivity(by: activityId, params: params)
        XCTAssertEqual(actual.id, activityId)
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    private func setupNetworkManager() -> HTTPRequest {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.protocolClasses?.insert(MockURLProtocol.self, at: 0)
        return HTTPRequestImpl(session: URLSession(configuration: sessionConfig))
    }
    
    private func requestShouldReturn(for endpoint: String, jsonFileName: String) throws {
        let data = try FileLoader.loadJson(name: jsonFileName)
        MockURLProtocol.mockData[endpoint] = data
    }
}

enum FileLoadError: Error {
    case couldNotFindFile
}
