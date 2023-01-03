import XCTest
import HTTPRequest
import OAuth
@testable import StravaApi

final class StravaApiTests: XCTestCase {
    
    func test_getProfileShouldReturn_Athlete() async throws {
        let sut = StravaApiImpl(
            oAuthClient: OAuthMock(),
            request: setupNetworkManager()
        )
        
        let response = try requestShouldReturn(for: "/api/v3/athlete", jsonFileName: "DetailedAthlete")
        
        let expectation = expectation(description: "Fetching profile")
        let expected: Athlete = try JSONDecoder().decode(Athlete.self, from: response)
        let actual: Athlete = try await sut.getProfile()
        XCTAssertEqual(actual, expected)
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    func test_getActivities_shouldReturnActivities() async throws {
        let sut = StravaApiImpl(
            oAuthClient: OAuthMock(),
            request: setupNetworkManager()
        )
        
        let response = try requestShouldReturn(for: "/api/v3/athlete/activities", jsonFileName: "DetailedActivities")
        
        let expectation = expectation(description: "Fetching activities")
        let expected: [DetailedActivity] = try JSONDecoder().decode([DetailedActivity].self, from: response)
        let actual: [DetailedActivity] = try await sut.getUserActivities()
        XCTAssertEqual(actual, expected)
        expectation.fulfill()
        wait(for: [expectation], timeout: 5)
    }
    
    private func setupNetworkManager() -> HTTPRequest {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.protocolClasses?.insert(MockURLProtocol.self, at: 0)
        return HTTPRequestImpl(session: URLSession(configuration: sessionConfig))
    }
    
    private func requestShouldReturn(for endpoint: String, jsonFileName: String) throws -> Data {
        let data = try FileLoader.loadJson(name: jsonFileName)
        MockURLProtocol.mockData[endpoint] = data
        return data
    }
}

enum FileLoadError: Error {
    case couldNotFindFile
}
