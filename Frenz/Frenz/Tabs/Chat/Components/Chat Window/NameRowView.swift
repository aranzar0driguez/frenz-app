//
//  NameRowView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/28/24.
//

import Foundation
import SwiftUI

struct NameRowView: View {
    
    var chatUser: user
    
    var body: some View {
        
            VStack {
                HStack {
                    
                    NavigationLink(value: chatUser) {
                        HStack {
                            ChatProfileView(chatUser: chatUser, rimColor: .clear, bigSize: false)
                                .padding(.trailing, 10)
                            
                            Text("\(chatUser.firstName) \(chatUser.lastName)")
                                .font(.custom("Minecraft", size: 20))
                                .foregroundStyle(.white)
                        }
                    }
                }
                
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(width: UIScreen.main.bounds.width, height: 1)
                
                
            }
            .navigationDestination(for: user.self) { user in
                CardView(showAdmirersGifts: false, showGiftSendingOptions: false, user: user, updateCardView: false)
            }
           
            .background(.black)
//        }
        
    }
}


#Preview {
    DirectMessagingView(user: MockUser.fakeUser, messagesID: "123")
}

