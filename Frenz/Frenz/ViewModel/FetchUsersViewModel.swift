//
//  FetchUsersViewModel.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 12/4/24.
//

import Foundation


final class FetchUsersViewModel: ObservableObject {
    @Published var otherUser: user
    
    init(user: user) {
        self.otherUser = user

    }
    
    func fetchUser() async -> user? {
        
        do {
            let updatedUser = try await UserManager.shared.getUser(userEmail: otherUser.email)
            print("Fetched the user from firebase!")

            if let birthday = updatedUser?.birthday, let u = updatedUser {
                let calendar = Calendar.current
                
                let ageComponents = calendar.dateComponents([.year], from: birthday, to: Date())
                
                print("Age component: \(ageComponents.year)")
                
                //  if the user's birthday is NOT up to date, it will update it on the backend...
                if u.age < ageComponents.year! {
                    
                    print("updating the user's bday...")
                    try await UserManager.shared.updateUserField(userEmail: u.email, ageComponents.year, codingKeyRawValue: user.CodingKeys.age.rawValue)
                }
                
            }
            
            DispatchQueue.main.async {
                self.otherUser = updatedUser ?? MockUser.fakeUser
                
            }
            return updatedUser
        } catch {
            print("Failed to fetch user: \(error)")
            return nil
        }
        
    }
}
