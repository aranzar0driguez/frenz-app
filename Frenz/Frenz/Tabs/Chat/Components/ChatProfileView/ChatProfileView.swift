//
//  ChatProfileView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/15/24.
//

import SwiftUI

struct ChatProfileView: View {
    
    var chatUser: user
    var gift: GiftReceived?
    var rimColor: Color
    var bigSize: Bool
    
    var body: some View {
        
        
        ZStack {
            
            
            ZStack {
                
                //  Make sure to change this later on!! user.imagesURL[0]
                if let imageURL = URL(string: chatUser.imagesURL[0]) {
                    VStack {
                        EventRemoteImage(urlString: imageURL)
                            .scaledToFill()
                            .frame(width: bigSize ? 80 : 60, height: bigSize ? 80: 60)
                            .clipShape(Circle())
                            .overlay(Circle()
                                .stroke(rimColor, lineWidth: 3))
                    }
                    
                }
                
                //  Will display a gift if it's meant to show a gift
                
                if gift != nil {
                    Image(gift!.giftType.rawValue)
                        .resizable()
                        .scaledToFill()
                        .frame(width: bigSize ? 50 : 35, height: bigSize ? 50 : 35)
                        .padding(.top, bigSize ? 75 : 45)
                        .padding(.leading, bigSize ? 55 : 50)
                    
                }
            }
        }
    }
}

//#Preview {
//    ChatProfileView(user: MockUser.fakeUser, gift: .init(sender: "", giftType: .cake, isThisARomanticGift: true), rimColor: .red, bigSize: false)
//}
