//
//  UserManager.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/18/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class UserManager {
    
    
    static let shared = UserManager()
    private init() { }
    
    //  References the "users" collection in Firestone
    private let userCollection = Firestore.firestore().collection("users")
    
    //  References a specific document within the users collection that matches the userId
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    
    func createNewUserInFirebase(u: user, userImages: [UIImage]) async throws {
        
        //  First thing this does is increase the user count and set that equal to the user's random Num value 
        guard let quantity = try await QuantityManager.shared.adjustUserCount(addUser: true) else {
            return 
        }

        //  Creates the user
        let document = userDocument(userId: u.email)
        
        var newUser = u
        newUser.randomNum = quantity
        
        try document.setData(from: newUser, merge: false)
        
        //  we are manually setting the keywords for lookup field for the user
        try await document.updateData([user.CodingKeys.keywordsForLookup.rawValue : u.keywordsForLookup])
//        
        for image in userImages {
            
            try await uploadUserImages(uiImage: image, userEmail: u.email)
        }
        
        
    }
    
    //  Set's the image's path and url in firebase
    func setPathandURL(userEmail: String, url: String, path: String) async throws {
        
        let snapshot = try await userDocument(userId: userEmail).getDocument()
        
        var patharray = snapshot.data()?[user.CodingKeys.paths.rawValue] as? [Any]
        var URLarray = snapshot.data()?[user.CodingKeys.imagesURL.rawValue] as? [Any]
        
        patharray?.append(path)
        URLarray?.append(url)
        
        let data: [String : Any] = [
            user.CodingKeys.paths.rawValue : patharray,
            user.CodingKeys.imagesURL.rawValue : URLarray
        ]
        
        
        try await userDocument(userId: userEmail).updateData(data)
        
    }
    
    func uploadUserImages(uiImage: UIImage, userEmail: String) async throws {
        
        //  We are going to compress the image first
        guard let jpegData = uiImage.jpegData(compressionQuality: 0.2) else { return }
        
        //  We are now going to upload that data into firebase
        let (path, name) = try await StorageManager.shared.saveImage(data: jpegData, userEmail: userEmail)

        //  Gets the URL for the image that was created
        let url = try await StorageManager.shared.returnURLForImage(path: path)
                
        //  Save's the images's path AND url in firebase
        try await setPathandURL(userEmail: userEmail, url: url.absoluteString, path: path)
    }
    
    func deleteUserImages(userEmail: String) async throws {
        
        print("3")

        let snapshot = try await userDocument(userId: userEmail).getDocument()
        
        
        print("4")

        var userImagePaths = snapshot.data()?[user.CodingKeys.paths.rawValue] as? [String]
        
        print("5")

        var userURLs = snapshot.data()?[user.CodingKeys.imagesURL.rawValue] as? [String]
        
        print("6")
        
        guard let paths = userImagePaths else { return }
        
        //  Deletes the images first from firebase
        
        
        print("7")

        for path in paths {
            print("8")

            
            try await StorageManager.shared.deleteImage(path: path)
            
        }
        
        userImagePaths = []
        userURLs = []
        
        let data: [String: Any] = [
            user.CodingKeys.paths.rawValue : userImagePaths,
            user.CodingKeys.imagesURL.rawValue : userURLs
        ]
        
        print("9")

        //  Deletes their image path/URL reference from firebase
        try await userDocument(userId: userEmail).updateData(data)
        
        print("10")

    }
    
    
    func deleteUserFromFirebase(userEmail: String, friendsGiftArray: [user], admirersGiftArray: [user]) async throws {
        let userDocument = userDocument(userId: userEmail)
        
        
        print("1")
        for user in friendsGiftArray {
            
           //
            let friendIndex = user.giftsReceived.firstIndex { gift in
                gift.otherUser == userEmail && gift.giftSentPurpose == .friends
                
            }
            
            if friendIndex != nil {
                try await deleteSpecificGift(indexOfGift: friendIndex!, userEmail: user.email)
            }
            
        }
        
        for user in admirersGiftArray {
            
            let admirerIndex = user.giftsReceived.firstIndex { gift in
                gift.otherUser == userEmail && gift.giftSentPurpose == .romantic
            }
            
            if admirerIndex != nil {
                try await deleteSpecificGift(indexOfGift: admirerIndex!, userEmail: user.email)
            }
            
        }
        
        print("2")

        
        //  Deletes images first
        try await deleteUserImages(userEmail: userEmail)
       
        //  The deletes the actual document
        try await userDocument.delete()
        
        print("This user has been successfully delete from firebase ")
    }
    
    func deleteSpecificGift(indexOfGift: Int, userEmail: String) async throws {
        
        //  Email of the person we're deleting from
        
        let snapshot = try await userDocument(userId: userEmail).getDocument()
        
        var array = snapshot.data()?[user.CodingKeys.giftsReceived.rawValue] as? [[String: Any]] ?? []

        array.remove(at: indexOfGift)
        
        // Update Firestore
        let data: [String: Any] = [
            user.CodingKeys.giftsReceived.rawValue: array
        ]
        
        try await userDocument(userId: userEmail).updateData(data)
        
    }
    
    //  Fetches and returns the user
    func getUser(userEmail: String) async throws -> user? {
        
        let u = try await userDocument(userId: userEmail).getDocument()
        
    
        guard u.exists else {
            return nil
        }
        
        let validUser = try u.data(as: user.self)
        
        return validUser
    }
      
    
    private func getUsersQuery() -> Query {
        userCollection
        
    }
    
    private func getUsersFilteredByAppUtilization(reason1: AppUtilizationPurpose, reason2: AppUtilizationPurpose)  -> Query {
        
        let descendingOrAscending = Int.random(in: 0...1) // 0 or 1
        let randomNum = Double.random(in: -1...1) // 0.0 - 1.0
        
        let query =  userCollection.whereField(user.CodingKeys.appUtilizationPurpose.rawValue,
                              in: [reason1.rawValue, reason2.rawValue]).whereField(user.CodingKeys.randomNum.rawValue, isGreaterThanOrEqualTo: randomNum)
        
        if descendingOrAscending == 0 {
            query.whereField(user.CodingKeys.randomNum.rawValue, isGreaterThanOrEqualTo: randomNum)
        }
        else {
            query.whereField(user.CodingKeys.randomNum.rawValue, isLessThanOrEqualTo: randomNum)

        }
        
        return query
        
    }
    
    
    func getAllUsersQuery(reason1: AppUtilizationPurpose? = nil, reason2: AppUtilizationPurpose? = nil, count: Int, lastDocument: DocumentSnapshot? = nil) async throws -> (users: [user], lastDocument: DocumentSnapshot?) {
        
        var query: Query = getUsersQuery()
        
        
        if reason1 != nil && reason2 != nil, let reason1 = reason1, let reason2 = reason2 {
            
            query = getUsersFilteredByAppUtilization(reason1: reason1, reason2: reason2)
            
        }
        
        if let lastDocument {
                        
            return try await query
                .limit(to: count)
                .start(afterDocument: lastDocument)
                .getDocumentsWithSnapshot(as: user.self)
            
        }  else {
            return try await query
                .limit(to: count)
                .getDocumentsWithSnapshot(as: user.self)
            
        }
        
    }
   
    //  w
    func sendUsersGift(receiverEmail: String, senderEmail: String, giftType: GiftType, giftSentPurpose: GiftSentPurpose, acceptedGift: Bool, messageID: String) async throws {
        let arrayOfEmails = [receiverEmail, senderEmail]
        
        for email in arrayOfEmails {
            let index = arrayOfEmails.firstIndex(of: email)
            let snapshot = try await userDocument(userId: email).getDocument()
            
            // Get the existing array or create a new one if it doesn't exist
            var array = snapshot.data()?[user.CodingKeys.giftsReceived.rawValue] as? [[String: Any]] ?? []
            
            // Create the gift object
            let gift = GiftReceived(
                otherUser: index == 0 ? senderEmail : receiverEmail,
                giftType: giftType,
                giftSentPurpose: giftSentPurpose,
                giftAction: index == 0 ? .received : .sent,
                acceptedGift: false,
                messageID: messageID
            )
            
            // Convert the gift to a dictionary
            let giftDict: [String: Any] = [
                "other_user": gift.otherUser,
                "gift_type": gift.giftType.rawValue,
                "gift_sent_purpose": gift.giftSentPurpose.rawValue,
                "gift_action": gift.giftAction.rawValue,
                "accepted_gift": gift.acceptedGift,
                "message_id" : gift.messageID
            ]
            
            // Append the dictionary to the array
            array.append(giftDict)
            
            // Update Firestore
            let data: [String: Any] = [
                user.CodingKeys.giftsReceived.rawValue: array
            ]
            
            try await userDocument(userId: email).updateData(data)
            
            print("Successfully updated user")
        }
    }
    
    func updateAcceptedChat(user1: String, user2: String, messageID: String) async throws {
        
        let users = [user1, user2]
        
        for u in users {
               let userSnapshot = try await userDocument(userId: u).getDocument()
               
               if var userGiftsArray = userSnapshot.data()?[user.CodingKeys.giftsReceived.rawValue] as? [[String: Any]] {
                   if let index = userGiftsArray.firstIndex(where: { giftDict in
                       return giftDict[GiftReceived.CodingKeys.messageID.rawValue] as? String == messageID
                   }) {
                       // Update the acceptedMessage field in the gift at the found index
                       userGiftsArray[index][GiftReceived.CodingKeys.acceptedGift.rawValue] = true
                       
                       try await userDocument(userId: u).updateData([
                           user.CodingKeys.giftsReceived.rawValue: userGiftsArray
                       ])
                       print("successfully updated the user's request")
                   }
               }
           }
        
    }
    
    //  Update specific property of user
    
    func updateUserField(userEmail: String, _ newValue: Any, codingKeyRawValue: String) async throws {
        

        let snapshot = try await userDocument(userId: userEmail).getDocument()
                
        let value = newValue
        
        let userData: [String: Any] = [
            codingKeyRawValue : value
        ]
    
        
        try await userDocument(userId: userEmail).updateData(userData)
        
    }
    
//    func updateCoordinateField(userEmail: String, newValue: Double, codingKeyRawValue: String) async throws {
//        
//        let snapshot = try await userDocument(userId: userEmail)
//        
//        let value = newValue
//        
//        let userData: [String: Any] = [
//            codingKeyRawValue : value
//        ]
//        
//        try await userDocument(userId: userEmail).updateData(userData)
//        
//    }
    
//    func updateArrayField(userEmail: String, newValue: [String], codingKeyRawValue: String) async throws {
//        
//        let snapshot = try await userDocument(userId: userEmail)
//        
//        let value = newValue
//        
//        let userData: [String: Any] = [
//            codingKeyRawValue : value
//        ]
//        
//        try await userDocument(userId: userEmail).updateData(userData)
//        
//    }
//    
    
    //  Updates the array of messages for both users
    func addMessageIDToBothUsers(user1: String, user2: String, messageID: String) async throws -> Bool {
                
        //  User1 = gift receiver 
        let users = [user1, user2]
        
        for u in users {
            
            do {
                let userSnapshot = try await userDocument(userId: u).getDocument()
                
                var userMessagesArray = userSnapshot.data()?[user.CodingKeys.messages.rawValue] as? [Any]
                
                userMessagesArray?.append(messageID)
                
                let userData: [String : Any] = [
                    user.CodingKeys.messages.rawValue : userMessagesArray
                ]
                
                try await userDocument(userId: u).updateData(userData)
            } catch {
                print("unable to successfully update the user!") // catches any error related to unable send a gift 
                return false    //  Returns fales if it is unable to successful fetch users 
            }

        }
        
        return true // If it is able to successfully fetch both users
        
    }
    
    func onlyUseForReplicationPurposes() async throws {
        
        var user = try await getUser(userEmail: "aranza.rodriguez@yale.edu")
        
        
        for i in 0..<100 {
            
            let randomNum = Int.random(in: 1...150)
            let randomGender = Int.random(in: 1...2)
            let randomAttractedSex = Int.random(in: 1...3)
            
            let randomEmail = "\(randomNum)aranzaRod@gmail.com"
            let randomLat = Double.random(in: 41.3025...41.3175)
            let randomLong = Double.random(in: -72.9375...(-72.9175))

            user?.sex = randomGender == 1 ? .female : .male
            
            if i < 35 {
                user?.appUtilizationPurpose = .friends
                
            }
            else if i < 65 {
                user?.appUtilizationPurpose = .friendsAndRomantic
            }
            else {
                user?.appUtilizationPurpose = .romantic
                
            }
            
            if randomAttractedSex == 1 { user?.attractedSex = .female }
            if randomAttractedSex == 2 { user?.attractedSex = .male }
            if randomAttractedSex == 3 { user?.attractedSex = .both }

            user?.email = randomEmail
            user?.id = UUID()
            user?.randomNum = i + 2
            user?.latitude = randomLat
            user?.longitude = randomLong
            user?.firstName = String(Int.random(in: 100...1000))
            user?.lastName = String(Int.random(in: 100...1000))
            
            guard let u = user else { return }
            
            try await UserManager.shared.createNewUserInFirebase(u: u, userImages: [])
            
            
            print("Sex: \(u.sex)")
            print("App Utilization: \(u.appUtilizationPurpose)")

            print("finished creating user number \(i)\n\n")

        }
        
    }
    


    
}

extension Query {
    
    
    func getDocuments<T>(as type: T.Type) async throws -> [T] where T: Decodable {
        
        try await getDocumentsWithSnapshot(as: type).users
        
    }
    
    func getDocumentsWithSnapshot<T>(as type: T.Type) async throws -> (users: [T], lastDocument: DocumentSnapshot?) where T : Decodable {
        
        let snapshot = try await self.getDocuments()
        
        let users = try snapshot.documents.map({ document in
            
            try document.data(as: T.self)
            
        })
        
        return (users, snapshot.documents.last)
        
    }
    
}
