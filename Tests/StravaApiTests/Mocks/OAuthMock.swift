import Foundation
import OAuth

class OAuthMock: OAuth {
    func authorize(authUrl url: URL) async throws -> URL {
        return try JSONDecoder().decode(URL.self, from: FileLoader.loadJson(name: "Token"))
    }
    
    func getAccessToken<TokenType>(currentToken: TokenType?, accessUrl: URL?) async throws -> TokenType? where TokenType : Decodable {
        return try JSONDecoder().decode(TokenType.self, from: FileLoader.loadJson(name: "Token"))
    }
    
    func refreshToken<TokenType>(refreshUrl: URL) async throws -> TokenType where TokenType : Decodable {
        return try JSONDecoder().decode(TokenType.self, from: FileLoader.loadJson(name: "Token"))
    }
}
