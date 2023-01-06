import XCTest
import HTTPRequest
import OAuth
@testable import StravaApi

final class StravaApiTests: XCTestCase {
    
    func createSUT() throws -> StravaApi {
        let sut = StravaApiImpl(config: StravaConfig.fixture, oAuthClient: OAuthMock(), request: setupNetworkManager())
        let token: Token = try JSONDecoder().decode(Token.self, from: try FileLoader.loadJson(name: "Token"))
        sut.registerTokenUpdate(current: token, callback: { _ in })
        return sut
    }
    
    func setupNetworkManager() -> HTTPRequest {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.protocolClasses?.insert(MockURLProtocol.self, at: 0)
        return HTTPRequestImpl(session: URLSession(configuration: sessionConfig))
    }
    
    func requestShouldReturn(for endpoint: String, jsonFileName: String) throws {
        let data = try FileLoader.loadJson(name: jsonFileName)
        MockURLProtocol.mockData[endpoint] = data
    }
}

enum FileLoadError: Error {
    case couldNotFindFile
}

extension StravaConfig {
    static let fixture = StravaConfig(authorizeUrl: "", tokenUrl: "", clientId: "", redirectUri: "", callbackURLScheme: "", clientSecret: "", scope: "")
}
