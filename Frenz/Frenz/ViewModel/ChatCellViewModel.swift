//
//  ChatCellViewModel.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/29/24.
//

import Foundation

class ChatCellViewModel: ObservableObject {
    
    enum LoadingState {
        
        case loading
        case loaded(user: user)
        case error(String)
        
    }
    
    @Published var state: LoadingState = .loading

    let messageID: String
    let loggedInUser: user
    
    init(messageID: String, loggedInUser: user) {
        self.messageID = messageID
        self.loggedInUser = loggedInUser
        fetchuser()
    }
    
    func fetchuser() {
        
        Task {
            do {
                //  Fetches the user 
                let fetchedUser = try await MessageManager.shared.getUserToText(messagesID: messageID, loggedInUser: loggedInUser)
                                
                await MainActor.run {
                    
                    self.state = .loaded(user: fetchedUser ?? MockUser.fakeUser)
                    
                }
            } catch {
                await MainActor.run {
                    self.state = .error(error.localizedDescription)
                }
            }
            
        }
        
    }
    
}
