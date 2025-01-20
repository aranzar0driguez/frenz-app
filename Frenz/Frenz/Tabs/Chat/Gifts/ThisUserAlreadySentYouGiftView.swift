//
//  ThisUserAlreadySentYouGiftView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 12/7/24.
//

import SwiftUI

struct ThisUserAlreadySentYouGiftView: View {
    
    @ObservedObject var cardViewModel : CardViewModel
    var showAdmirerGift: Bool

    
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(showAdmirerGift ? "This user has already sent you a romantic gift. Refresh your DMs to check it out!" : "This user has already sent you a friend gift. Refresh your DMs to check it out!")
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
    ThisUserAlreadySentYouGiftView(cardViewModel: CardViewModel(), showAdmirerGift: false)
}
