//
//  AuthenticationManager.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/18/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    
    let uid: String
    let email: String?
    
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() {}
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    //  Google account deletion
    func deleteAccount(authCredential: AuthCredential) async throws {
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        
        //  Delete user data too?
        try await user.reauthenticate(with: authCredential)
        
        try await user.delete()
        
        print("Deletion is successful")
    }
    
    
}


extension AuthenticationManager{
    
    @discardableResult
    func signInWithGoogle(GoogleSignInToken: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: GoogleSignInToken.idToken, accessToken: GoogleSignInToken.accessToken)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
        
    }
    
}
