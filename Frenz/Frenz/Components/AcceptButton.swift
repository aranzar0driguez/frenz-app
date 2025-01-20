//
//  AcceptButton.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/14/24.
//

import SwiftUI

struct AcceptButton: View {
    
    var buttonText: String
    var backgroundColor: Color
    var width: CGFloat?
    var textColor: Color?
    
    var body: some View {
        
        Text("\(buttonText)")
            .font(.custom("Minecraft", size: 20))
            .foregroundStyle(textColor ?? .white)
            .padding([.leading, .trailing], 15)
            .padding([.top, .bottom], 10)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .frame(width: width != nil ? width : 200)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(.white, lineWidth: 2))

    }
}

#Preview {
    AcceptButton(buttonText: "Yes", backgroundColor: .green, width: 300)
}
