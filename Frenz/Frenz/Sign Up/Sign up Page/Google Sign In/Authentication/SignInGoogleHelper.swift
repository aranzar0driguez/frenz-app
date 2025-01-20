//
//  SignInGoogleHelper.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/18/24.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInResultModel {
    
    var idToken: String
    let accessToken: String
    
}


final class SignInGoogleHelper {
    
    @MainActor
    func signIn() async throws -> GoogleSignInResultModel  {
        
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        
        let GIDSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        

        
        guard let idToken = GIDSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        

        let accessToken = GIDSignInResult.user.accessToken.tokenString
        
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        return tokens
        
    }
    
}
