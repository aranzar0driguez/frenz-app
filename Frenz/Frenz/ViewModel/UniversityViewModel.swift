//
//  UniversityViewModel.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/29/24.
//

import Foundation

@MainActor
final class UniversityViewModel: ObservableObject {
    
    //  Set this variable to something AFTER user successfully signs up 
    @Published var university: University? = nil
    
    @MainActor
    func loadUniversity(universityID: String) async throws {
        
        university = nil
        
        Task {
            let university = try await UniversityManager.shared.getUniversity(universityID: universityID)
            
            self.university = university
            
        }
    }
    
}
