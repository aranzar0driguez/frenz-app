//
//  WhiteBoxButton.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/17/24.
//

import SwiftUI

struct WhiteBoxButton: View {
    
    var buttonText: String
    var isSelected: Bool
    var buttonWidth: CGFloat
    var buttonHeight: CGFloat
    var action: () -> Void
    
    
    var body: some View {
        

        
        Button(action: action) {
            Text("\(buttonText)")
                .font(.custom("Minecraft", size: 16))
                .foregroundStyle(isSelected ? .black : .white)
                .padding([.leading, .trailing], 10)
                .padding(.bottom, 4)
                .padding(.top, 6)
                .frame(width: buttonWidth, height: buttonHeight)
                .background(isSelected ? .white : .black)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? .black : .white, lineWidth: 2))

        }
    }
    
}

