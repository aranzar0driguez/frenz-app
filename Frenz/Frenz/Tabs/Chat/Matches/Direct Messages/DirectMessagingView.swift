//
//  DirectMessagingView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/15/24.
//

import SwiftUI

struct DirectMessagingView: View {
      
    var user: user
    var messagesID: String
    @StateObject private var messagesVM: MessagesViewModel
    
    init(user: user, messagesID: String) {
        self.user = user
        self.messagesID = messagesID
        _messagesVM = StateObject(wrappedValue: MessagesViewModel(messagesDocumentID: messagesID))
    }
    
    //  The user they're chatting with
    
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    
                    NameRowView(chatUser: user)
                    
                    ScrollView {
                        ScrollViewReader { proxy in
                            LazyVStack {
                                ForEach(messagesVM.messages, id: \.id) { text in
                                    MessageBubble(message: text)
                                        .id(text)
                                }
                            }
                            .padding(.top, 10)
                            
                            .onChange(of: messagesVM.messages.last) { msg in
                                withAnimation {
                                    proxy.scrollTo(msg)
                                }
                            }
                        }
                    }
                }
                
                MessageFieldView(receiver: user, messagesID: messagesID)
                
            }
            
        }
        
    }
    
    
}
//
//#Preview {
//    DirectMessagingView(user: MockUser.fakeUser)
//}
