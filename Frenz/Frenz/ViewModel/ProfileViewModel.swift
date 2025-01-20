//
//  ProfileViewModel.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/18/24.
//

import Foundation
import FirebaseAuth

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: user? = nil
    
    //  DELTED THIS
//    @Published private(set) var usersForChat: [user] = []
//    @Published private(set) var messagesInfo: [MessageInfo] = []
    //  DELETED THIS
    
    
//    @MainActor
//    func loadCurrentUser() async throws {
//        
//        let authDataResult = try await AuthenticationManager.shared.getAuthenticatedUser()
//        
//        let fetchedUser = try await UserManager.shared.getUser(userEmail: authDataResult.email ?? "")
//        
//        self.user = fetchedUser
//        
//        dataFinishedLoading = true
//        
//    }
    @MainActor
    func loadCurrentUser() async throws {
                
        // Using Task to properly handle async operations and memory
        try await Task { [weak self] in
            guard let self = self else { return }
            
            let authDataResult = try await AuthenticationManager.shared.getAuthenticatedUser()
            let fetchedUser = try await UserManager.shared.getUser(userEmail: authDataResult.email ?? "")
            
            // Check again if self is still valid after the async operations
            guard !Task.isCancelled else { return }
            
            
            self.user = fetchedUser
            print("The current logged in user is: \(user?.email)")
            
        }.value
    }
    
    func deleteUser(authCredential: AuthCredential, userEmail: String, friendsGiftArray: [user], admirersGiftArray: [user]) async throws {
        
        

        try await UserManager.shared.deleteUserFromFirebase(userEmail: userEmail, friendsGiftArray: friendsGiftArray, admirersGiftArray: admirersGiftArray)
        print("11")

        try await AuthenticationManager.shared.deleteAccount(authCredential: authCredential)
        
        
    }
    
    //  DELTED THIS

//    func getUsersForChatAndMessageInfoArray(messagesID: [String], loggedInUser: user) async throws {
//        
//        //  This may return a nil 
//        let users = try await MessageManager.shared.getAllUsersToText(messagesID: messagesID, loggedInUser: loggedInUser)
//        
//        let messageInfoArray = try await MessageManager.shared.getAllMessageInfo(loggedInUser: loggedInUser)
//        
//        self.messagesInfo = messageInfoArray
//        self.usersForChat = users
//        
//        print("\(messageInfoArray)")
//        
//    }
    
    //  DELTED THIS

}
