//
//  ChatCellView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/15/24.
//

import SwiftUI

struct ChatCellView: View {
    
    @EnvironmentObject var profileVM : ProfileViewModel
    @StateObject private var chatCellVM: ChatCellViewModel
    
    @StateObject private var messagesVM: MessagesViewModel
    
    @Binding var index : Int
    var loggedInUser: user
    
    init(message: String, index: Binding<Int>, loggedInUser: user) {
        _chatCellVM = StateObject(wrappedValue: ChatCellViewModel(messageID: message, loggedInUser: loggedInUser))
        _index = index
        self.loggedInUser = loggedInUser
        _messagesVM = StateObject(wrappedValue: MessagesViewModel(messagesDocumentID: message, signedInUser: loggedInUser.email))
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                
            
                switch chatCellVM.state {
                    
                case .loading:
                    ProgressView()
                        .frame(width: UIScreen.main.bounds.width - 15)
                    
                case .loaded(let user):
                   
                        ChatProfileView(chatUser: user, rimColor: .clear, bigSize: true)
                            .padding([.leading, .trailing], 15)
                        
                    VStack (alignment: .leading) {
                        HStack {
                            Text("\(user.firstName)")
                            
                            Text("\(user.lastName)")
                            
                        }
                        .font(.custom("Minecraft", size: 19))
                        
                        Spacer()
                        
                        Text(messagesVM.latestMessage == "" ? "Click to start chatting!" : "\(messagesVM.latestMessage)")
                            .font(.custom("Minecraft", size: 15))
                            .padding(.bottom, 10)
                        
                    }
                    .foregroundColor(.white)
                    .frame(height: 30)
                    
                    Spacer()
                    
                case .error(let errorMessage):
                    Text("Error \(errorMessage)")
                        .frame(width: UIScreen.main.bounds.width - 15)

                    
                }
            }
                    
                    
                    
//                }
                
            }
        .frame(width: UIScreen.main.bounds.width - 15)
            
            
        }
        
       
        
    }

//
//#Preview {
//    ChatCellView(user: MockUser.fakeUser, gift: gift)
//}
