//
//  ThereHasBeenAnErrorView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 12/5/24.
//

import SwiftUI

struct ThereHasBeenAnErrorView: View {
    
    @ObservedObject var cardViewModel : CardViewModel

    
    var body: some View {
        VStack {
            Text("There has been an error sending the gift!")
                .font(.custom("Minecraft", size: 20))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            
            Button {
                
                cardViewModel.showGiftGivingConfirmationScreen = false
                cardViewModel.showGiftOptions = false

                
            } label : {
                
                AcceptButton(buttonText: "OK", backgroundColor: .blue, width: 80)
                
            }
        }
    }
}

#Preview {
    ThereHasBeenAnErrorView(cardViewModel: CardViewModel())
}
