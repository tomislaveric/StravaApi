//
//  File.swift
//  
//
//  Created by Tomislav Eric on 01.01.23.
//

import Foundation
import OAuth

class OAuthMock: OAuth {
    
    func getAccessToken(currentToken: Token?) async throws -> Token? {
        return try JSONDecoder().decode(Token.self, from: FileLoader.loadJson(name: "Token"))
    }
}
