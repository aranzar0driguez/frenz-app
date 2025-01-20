//
//  MessageFieldView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/28/24.
//

import SwiftUI

struct MessageFieldView: View {
    
    @EnvironmentObject var profileVM : ProfileViewModel
    @State private var message = ""
    var receiver: user
    var messagesID: String

    
    var body: some View {
        HStack {
            CustomTextField(placeholder: Text("Send a message!"), text: $message)
            
            Button {
                
                Task {
                    
                //  This line works to create the messages inital conversation!
//                    try await MessageManager.shared.createMessageMainDocument(messageInfo: MessageInfo(fromEmail: "fromEmail@testing.come", toEmail: "toEmail@testing.com", lastMessage: ""))
                    
                    guard let userLoggedInEmail = profileVM.user?.email else { return }
                   
                    let sentTextMessage = message
                    
                    message = ""
                    
                    try await MessageManager.shared.addMessageToSubCollection(messagesDocumentID: messagesID, message: Message(text: sentTextMessage, timeStamp: Date(), sender: userLoggedInEmail, receiver: receiver.email))
                    
                    //  TODO: SEND THE NOTIFICATION OF THE MESSAGE SENT
                    
                    await SendNotifCloudFunction.shared.sendNotif(fcmToken: [receiver.fcmToken], title: "New Message 📝", message: "\(sentTextMessage)")

                }
                
               
            } label : {
                Image(systemName: "paperplane.fill")
                    .foregroundStyle(.white)
                    .padding(10)
                    .cornerRadius(50)
            }
            
            
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .cornerRadius(50)
    }
}

//#Preview {
//    MessageFieldView()
//}

struct CustomTextField: View {
    
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .font(.custom("Minecraft", size: 16))
                    .opacity(0.5)
                    .padding()
                    .foregroundStyle(.white)

            }
            
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .font(.custom("Minecraft", size: 16))
                .foregroundStyle(.white)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth: 2))
        }
        
    }
    
}
