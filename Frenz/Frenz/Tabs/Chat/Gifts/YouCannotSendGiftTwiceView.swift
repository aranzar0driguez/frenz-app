//
//  YouCannotSendGiftTwiceView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 12/2/24.
//

import SwiftUI

struct YouCannotSendGiftTwiceView: View {
    
    @ObservedObject var cardViewModel : CardViewModel
    var user: user
    var showAdmirerGift: Bool

    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(showAdmirerGift ? "You have already sent \(user.firstName) a romantic gift before. You can only send one." : "You have already sent \(user.firstName) a friend gift before. You can only send one.")
                    .multilineTextAlignment(.center)
                    .font(.custom("Minecraft", size: 20))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                HStack {
                    
                    Button {
                        cardViewModel.showGiftOptions = false
                        cardViewModel.showGiftGivingConfirmationScreen = false

                    } label : {
                        AcceptButton(buttonText: "OK", backgroundColor: .blue, width: 80, textColor: .white)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    YouCannotSendGiftTwiceView(cardViewModel: CardViewModel(), user: MockUser.fakeUser, showAdmirerGift: true)
}
