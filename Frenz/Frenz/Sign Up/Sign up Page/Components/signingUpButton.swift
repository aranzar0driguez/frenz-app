//
//  signingUpButton.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/18/24.
//

import SwiftUI

struct signingUpButton: View {
    
    var buttonText: String
    
    var body: some View {
        Text(buttonText)
            .font(.custom("Minecraft", size: 16))
            .foregroundStyle(.black)
            .padding([.leading, .trailing], 10)
            .padding(.bottom, 4)
            .padding(.top, 6)
            .frame(width: UIScreen.main.bounds.width - 20, height: 50)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(.white, lineWidth: 2))
            .padding(.bottom, 20)
    }
}

#Preview {
    signingUpButton(buttonText: "text")
}
