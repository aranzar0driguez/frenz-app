//
//  BubbleButtonTapped.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/16/24.
//

import SwiftUI

struct BubbleButtonTapped: View {
    
    var buttonText: String
    var isSelected: Bool
    var color: Color
    var tappedFontColor: Color = .white

    
    var body: some View {
       
            Text("\(buttonText)")
                .font(.custom("Minecraft", size: 16))
                .foregroundStyle(isSelected ? tappedFontColor : color)
                .padding([.leading, .trailing], 10)
                .padding(.bottom, 4)
                .padding(.top, 6)
                .background(isSelected ? color : .clear)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(color, lineWidth: 2))

            
       
        
        
    }
}

#Preview {
    BubbleButtonTapped(buttonText: "Text", isSelected: true, color: .black)
}
