//
//  UniversityManager.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/29/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class UniversityManager {
    
    static let shared = UniversityManager()
    private init() {  }
    
    private let universityCollection = Firestore.firestore().collection("universities")
    
    private func universityDocument(universityID: String) -> DocumentReference {
        
        universityCollection.document(universityID)
    }
    
    func getUniversity(universityID: String) async throws -> University? {
        
        let university = try await universityDocument(universityID: universityID).getDocument()
        
        guard university.exists else {
            return nil
        }
        
        let validUniversity = try university.data(as: University.self)
        
        return validUniversity
        
    }
    
    func findValidUniversityEmail(emailEnding: String) async throws -> University? {
        
        do {
            let query = universityCollection
                .whereField(University.CodingKeys.emailEnding.rawValue, isEqualTo: emailEnding)
                .limit(to: 1)
            
            print("made it here")
            
            let snapshot = try await query.getDocuments()
            
            print("made it here")

            
            if let document = snapshot.documents.first {
                
                let validUniversity = try document.data(as: University.self)
                print("Found valid university!")
                return validUniversity
            }
            
        } catch {
            print(error)
            return nil
        }
        print("Made it to the end")
        return nil

    }
    
}
