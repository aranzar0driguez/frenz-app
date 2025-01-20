//
//  MessageBubble.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/28/24.
//

import SwiftUI

struct MessageBubble: View {
    
    var message: Message
    @EnvironmentObject var profileVM : ProfileViewModel
    
    @State private var showTime = false
    
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: message.sender == profileVM.user!.email ? .trailing : .leading) {
                
                HStack {
                    Text(message.text)
                        .padding()
                        .font(.custom("Minecraft", size: 16))
                        .foregroundStyle(.white)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 1.5))
                }
                .frame(maxWidth: 300, alignment: message.sender == profileVM.user!.email ? .trailing : .leading)
                .onTapGesture {
                    showTime.toggle()
                }
                
                Text(message.timeStamp.formatted(.dateTime.hour().minute()))
                    .foregroundStyle(showTime == true ? .gray : .clear)
                    .font(.custom("Minecraft", size: 10))
                    .padding(message.sender == profileVM.user!.email ? .trailing : .leading, 25)
                
                
            }
            .frame(maxWidth: .infinity, alignment: message.sender == profileVM.user!.email ? .trailing : .leading)
            .padding(message.sender == profileVM.user!.email ? .trailing : .leading)
            //        .padding(.horizontal, 1)
        }
    }
}

#Preview {
    MessageBubble(message: Message(text: "I'm not really sure what to type here but just want to say hi!! I also want to say that I really like this UI because it really pops out!", timeStamp: Date(), sender: "RandomEmail", receiver: "randomEmail"))
}
