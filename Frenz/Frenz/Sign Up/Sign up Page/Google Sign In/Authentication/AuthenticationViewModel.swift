//
//  AuthenticationViewModel.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/18/24.
//

import Foundation
import FirebaseAuth


@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    @Published var userAlreadyExists: Bool = false
    @Published var showFullScreenCover: Bool = false
    @Published var numOfTimesButtonPressed: Int = 0
    @Published var userEmail = ""
    @Published var universityID = ""
    
    func signInGoogle() async throws -> AuthCredential{
        
        
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        
        let authCredential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)

        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(GoogleSignInToken: tokens)
        
        do {
            //  If that user doesn't exist... this will throw a firebase error b/c they won't have permission 
            userAlreadyExists = ((try await UserManager.shared.getUser(userEmail: authDataResult.email ?? "")) != nil)
            
            print("User already exists value: \(userAlreadyExists)")
            
            userEmail = authDataResult.email ?? ""
            
            numOfTimesButtonPressed += 1
            return authCredential
        } catch {
            throw error
        }

    }
    
}
