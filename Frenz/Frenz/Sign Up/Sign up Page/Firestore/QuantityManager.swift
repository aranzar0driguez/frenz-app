//
//  QuantityManager.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/28/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class QuantityManager {
    
    static let shared = QuantityManager()
    private init() { }
    
    private let quantityCollection = Firestore.firestore().collection("quantity")
    
    private func quantityDocument() -> DocumentReference {
        quantityCollection.document("total_num_of_users")
    }
    
    func adjustUserCount(addUser: Bool) async throws -> Int? {
        
        let snapshot = try await quantityDocument().getDocument()
        
        guard var quantity = snapshot.data()?["users"] as? Int else {
            return nil
        }
        
        if addUser {
            quantity += 1
        } else {
            quantity -= 1
        }

        let quantityData : [String : Int] = [
            "users" : quantity
        ]

        try await quantityDocument().updateData(quantityData)
        
        return quantity
        
    }
    
    func getUserCount() async throws  -> Int? {
        
        let snapshot = try await quantityDocument().getDocument()
        
        guard var quantity = snapshot.data()?["users"] as? Int else {
            return nil
        }
        
        return quantity
    }
    
}
