//
//  NextButton.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/16/24.
//

import SwiftUI

struct NextButton: View {
    
    var buttonText: String
    var textColor: Color
    var buttonColor: Color
    var buttonWidth: CGFloat?
    var buttonHeight: CGFloat?
    var isDisabled: Bool
    
    var body: some View {
        
        
        
        VStack {
            Text("\(buttonText)")
                .font(.custom("Minecraft", size: 20))
                .foregroundStyle(textColor)
                .padding([.leading, .trailing], 15)
                .padding([.top, .bottom], 10)
                .frame(width: buttonWidth != nil ? buttonWidth: 250, height: buttonHeight != nil ? buttonHeight : 50)
                .background(isDisabled ? .gray : buttonColor)
                .clipShape(RoundedRectangle(cornerRadius: 15))

        }
        
    }
}

#Preview {
    NextButton(buttonText: "Next", textColor: .white, buttonColor: .black, isDisabled: true)
}
