//
//  MainWarningScreenView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 12/13/24.
//

import SwiftUI

struct MainWarningScreenView: View {
    
    var message: String
    
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text(message)
                    .foregroundStyle(.white)
                    .font(.custom("Minecraft", size: 20))
                    .lineSpacing(4)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 15)
                    .frame(width: UIScreen.main.bounds.width - 20, height: 220)
                    .minimumScaleFactor(0.5)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 3))
                    .padding(.bottom, 60)
                
                Spacer()
            }
        }
    }
}

#Preview {
    MainWarningScreenView(message: "Test Message")
}
