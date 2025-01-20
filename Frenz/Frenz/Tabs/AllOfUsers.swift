//
//  AllOfUsers.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/19/24.
//

import Foundation
import FirebaseFirestore
import UIKit

//  This class is meant to give us access to ALL of the users on firebase

final class AllOfUsers: ObservableObject {
    
    //  We later want to make two types of arrays, one that has users they would be attracted to + those who they could be friends with ?
    @Published var limitedUsers: [user] = []
    @Published var searchedUsers: [user] = []
    @Published var friendsMap: [user] = []
    @Published var admirersMap: [user] = []
    @Published var friendsCards: [user] = []
    @Published var admirersCards: [user] = []
    
    
    @Published var romanticGiftUsers: [user] = []
    @Published var friendGiftUsers: [user] = []
    
    private var lastDocument: DocumentSnapshot? = nil
    @Published var hasMoreUsers = true  // Add this property

    
    
    @MainActor
    func getQueriedUsers(limit: Int) async throws {
        
        guard hasMoreUsers else { return }
        
        let (newUsers, lastDocument) = try await UserManager.shared.getAllUsersQuery(count: limit, lastDocument: lastDocument)
        self.limitedUsers.append(contentsOf: newUsers)
        self.lastDocument = lastDocument
        
        self.hasMoreUsers = newUsers.count == limit
    }
    
    @MainActor
    func resetQueriedUsers() {
        limitedUsers = []
        lastDocument = nil
    }
    
    @MainActor
    func getFilteredUsers(appUtilizationPurpose: AppUtilizationPurpose, usersOnMap: Bool, user: user) async throws -> [String]{
        
        var emails: [String] = []
        
        if let userSexuality = user.attractedSex?.rawValue, let userGender = user.sex?.rawValue {
            
            if appUtilizationPurpose == .romantic { //  For soley romantic users
                
                emails = await GetRandomUsersCloudFunction().getRandomUsers(userEmail: user.email, userGender: userGender, userSexuality: userSexuality, fetchRomanticUsers: true) ?? []
                
                if usersOnMap {
                    admirersMap = []
                    
                } else {
                    admirersCards = []
                }
                
                
            } else {    //  For soley friend users
                
                emails = await GetRandomUsersCloudFunction().getRandomUsers(userEmail: user.email, userGender: userGender, userSexuality: userSexuality, fetchRomanticUsers: false) ?? []
                
                if usersOnMap {
                    friendsMap = []
                    
                } else {
                    friendsCards = []
                }
            }
        
        try await getUsersFromEmails(emails: emails, appUtilizationPurpose: appUtilizationPurpose, usersOnMap: usersOnMap)
            
        }
        return emails
    }
    
    @MainActor
    func getUsersFromEmails(emails: [String], appUtilizationPurpose: AppUtilizationPurpose, usersOnMap: Bool) async throws {
        
        for email in emails {
            
            
            if let user = try await UserManager.shared.getUser(userEmail: email) {
                //  Only friends
                if appUtilizationPurpose == .friends {
                    //  For those on the map
                    if usersOnMap {
                        friendsMap.append(user)

                    //  For those on cards
                    } else {
                        friendsCards.append(user)

                    }
                //  Only admirers
                } else {
                    //  For those on the map
                    if usersOnMap {
                        admirersMap.append(user)

                        
                    //  For those on cards
                    } else {
                        admirersCards.append(user)

                    }
                }
            }
        }
    }
    
    @MainActor
    func resetUsersArray() {
        //  In case the user logs out and a new logs in, this erases the previous user's matches 
        friendsCards = []
        friendsMap = []
        admirersCards = []
        admirersMap = []
        
    }
    
    @MainActor
    func fetchUsers(from keyword: String) {
        
        Firestore.firestore().collection("users")
            .whereField(user.CodingKeys.keywordsForLookup.rawValue, arrayContains: keyword).getDocuments { querySnapshot, error in
                guard let documents = querySnapshot?.documents, error == nil else { return }
                self.searchedUsers = documents.compactMap({ queryDocumentSnapshot in
                    try? queryDocumentSnapshot.data(as: user.self)
                })
                
            }
  
    }
    
    @MainActor
    func updateNewUserValue(updatedUser: user) {
        
        if friendsMap.contains(updatedUser) {
            guard let index = friendsMap.firstIndex(of: updatedUser) else {
                return
            }
            friendsMap[index] = updatedUser
        }
        
        if friendsCards.contains(updatedUser) {
            guard let index = friendsCards.firstIndex(of: updatedUser) else {
                return
            }
            friendsCards[index] = updatedUser
        }
        if admirersMap.contains(updatedUser) {
            guard let index = admirersMap.firstIndex(of: updatedUser) else {
                return
            }
            admirersMap[index] = updatedUser
        }
        if admirersCards.contains(updatedUser) {
            guard let index = admirersCards.firstIndex(of: updatedUser) else {
                return
            }
            admirersCards[index] = updatedUser
        }
    }
        
    //  Maybe consider doing something with this, though it seems to be quite buggy... 
    
    
//    @MainActor
//    func updatedAfterAcceptedGift(giftSentPurpose: GiftSentPurpose, gift: GiftReceived, otherUser: user) {
//        
//        if giftSentPurpose == .friends {
//            
//            
//            
//            guard let index = friendGiftUsers.firstIndex(of: otherUser) else { return }
//
//            guard let index2 = friendGiftUsers[index].giftsReceived.firstIndex(of: gift) else { return }
//
//            friendGiftUsers[index].giftsReceived[index2].acceptedGift = true
//            
//        } else if giftSentPurpose == .romantic {
//            
//            
//            guard let index = romanticGiftUsers.firstIndex(of: otherUser) else { return }
//
//            guard let index2 = romanticGiftUsers[index].giftsReceived.firstIndex(of: gift) else { return }
//
//            romanticGiftUsers[index].giftsReceived[index2].acceptedGift = true
//            
//            print("\(romanticGiftUsers[index].giftsReceived[index2])")
//        }
//        
//    }
    
    //  Allows us to fetch all of the users who are in the giftsReceived array
    @MainActor
    func getAllGiftsArrayUsers(userEmail: String) async throws {
        
        let loggedInUser = try await UserManager.shared.getUser(userEmail: userEmail)
        
        //  resets to 0 
        self.romanticGiftUsers = []
        self.friendGiftUsers = []
        
        if let arrayOfGifts = loggedInUser?.giftsReceived {
            
            for gift in arrayOfGifts {
                
                
                guard let user = try await UserManager.shared.getUser(userEmail: gift.otherUser) else { return }
                

                if gift.giftSentPurpose == .romantic {
                   
                    self.romanticGiftUsers.append(user)
                    
                } else if gift.giftSentPurpose == .friends{
                   
                    self.friendGiftUsers.append(user)
                }
                                
            }
            
        }
        
        
    }
    
}
