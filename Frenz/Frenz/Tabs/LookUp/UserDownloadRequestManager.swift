//
//  UserDownloadRequestManager.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/21/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class UserDownloadRequestManager {
    
    static let shared = UserDownloadRequestManager()
    private init() {}
    
    private let requestsCollection = Firestore.firestore().collection("requests")
    
    private func requestDocument(userEmail: String) -> DocumentReference {
        requestsCollection.document(userEmail)
    }
    
    func createNewRequest(request: UserDownloadRequest) async throws {
        
        var r = request
        
        //  If the user already exists, let's go ahead and change the request's value
        if let user = try await UserManager.shared.getUser(userEmail: r.emailBeingSentTo) {
            r.userIsAlreadyInApp = true
            print("user already exists")
        }
            
        //  If the request object is already in firebase...
        if var validRequest = try await getRequest(requestEmailID: r.emailBeingSentTo) {
            
            let snapshot = try await requestDocument(userEmail: validRequest.emailBeingSentTo).getDocument()

            
            var emailsArray = snapshot.data()?[UserDownloadRequest.CodingKeys.requestUserEmail.rawValue] as? [String]

            
            emailsArray?.append(r.requestUserEmail[0])

            
            let data: [String : Any] = [
                UserDownloadRequest.CodingKeys.requestUserEmail.rawValue : emailsArray,
                UserDownloadRequest.CodingKeys.userIsAlreadyInApp.rawValue : r.userIsAlreadyInApp
            ]

            
            try await requestDocument(userEmail: r.emailBeingSentTo).updateData(data)

            
            
        //  If the request object is NOT already in firebase...
        } else {
            
            let document = requestDocument(userEmail: r.emailBeingSentTo)

            try document.setData(from: r, merge: false)
            
        }
        
    }
    
    
    func getRequest(requestEmailID: String) async throws -> UserDownloadRequest? {
        
        let request = try await requestDocument(userEmail: requestEmailID).getDocument()
        
        guard request.exists else {
            return nil
        }
        
        let validRequest = try request.data(as: UserDownloadRequest.self)
        
        return validRequest
        
    }
    
}
