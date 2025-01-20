//
//  BubbleButton.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/14/24.
//

import SwiftUI

struct BubbleButton: View {
    
    var interest: String
    var color: Color
    
    var body: some View {
        
        Text("\(interest)")
            .font(.custom("Minecraft", size: 16))
            .padding([.leading, .trailing], 10)
            .padding([.top, .bottom], 4)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(color, lineWidth: 2))
            .foregroundColor(color)
            
        
    }
}

#Preview {
    BubbleButton(interest: "Sports", color: .black)
}
