//
//  GiftSentConfirmationView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 12/2/24.
//

import SwiftUI

struct GiftSentConfirmationView: View {
    
    @ObservedObject var cardViewModel : CardViewModel

    
    var body: some View {
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Your gift has been successfully sent!")
                    .multilineTextAlignment(.center)
                    .font(.custom("Minecraft", size: 20))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                Button {
                    cardViewModel.showGiftHasBeenSuccessfullySentView = false
                    cardViewModel.showGiftOptions = false 
                } label : {
                    AcceptButton(buttonText: "Ok", backgroundColor: .blue, width: 80, textColor: .white)
                }
            }
        }
    }
}

#Preview {
    GiftSentConfirmationView(cardViewModel: CardViewModel())
}
