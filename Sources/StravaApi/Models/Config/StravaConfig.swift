import Foundation

public struct StravaConfig {
    public init(
        authorizeUrl: String,
        tokenUrl: String,
        clientId: String,
        redirectUri: String,
        callbackURLScheme: String,
        clientSecret: String,
        scopes: [Scope],
        approvalPrompt: ApprovalPrompt = .auto
    ) {
        self.authorizeUrl = authorizeUrl
        self.tokenUrl = tokenUrl
        self.clientId = clientId
        self.redirectUri = redirectUri
        self.callbackURLScheme = callbackURLScheme
        self.clientSecret = clientSecret
        self.scopes = scopes
        self.approvalPrompt = approvalPrompt
    }
    
    public let authorizeUrl: String
    public let tokenUrl: String
    public let clientId: String
    public let redirectUri: String
    public let callbackURLScheme: String
    public let clientSecret: String
    public let scopes: [Scope]
    public let responseType: String = "code"
    public let approvalPrompt: ApprovalPrompt
    public let authorizationGrant: String = "authorization_code"
    public let refreshGrant: String = "refresh_token"
}

public enum ApprovalPrompt: String {
    case auto
    case force
}
