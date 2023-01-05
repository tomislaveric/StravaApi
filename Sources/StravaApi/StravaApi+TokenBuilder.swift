import Foundation

extension StravaApiImpl {
    func buildAccessTokenUrl(from authResponse: URL) -> URL? {
        guard let authComponents = URLComponents(url: authResponse, resolvingAgainstBaseURL: true) else { return nil }
        let authToken = authComponents.queryItems?.first(where: { $0.name == self.config.responseType })?.value
        
        var components = URLComponents(string: config.tokenUrl)
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: config.clientId),
            URLQueryItem(name: "client_secret", value: config.clientSecret),
            URLQueryItem(name: "code", value: authToken),
            URLQueryItem(name: "scope", value: config.scope),
            URLQueryItem(name: "grant_type", value: config.authorizationGrant)
        ]
        return components?.url
    }
    
    func buildRefreshTokenUrl<TokenType: Decodable>(from token: TokenType) -> URL? {
        guard let token = token as? Token else { return nil }
        var components = URLComponents(string: config.tokenUrl)
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: config.clientId),
            URLQueryItem(name: "client_secret", value: config.clientSecret),
            URLQueryItem(name: "refresh_token", value: token.refresh_token),
            URLQueryItem(name: "grant_type", value: config.refreshGrant)
        ]
        return components?.url
    }
    
    func buildAuthUrl(from config: StravaConfig) -> URL? {
        var components = URLComponents(string: config.authorizeUrl)
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: config.clientId),
            URLQueryItem(name: "redirect_uri", value: config.redirectUri),
            URLQueryItem(name: "response_type", value: config.responseType),
            URLQueryItem(name: "scope", value: config.scope)
        ]
        return components?.url
    }
}
