//
//  CustomTextEditorView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/16/24.
//

import SwiftUI

struct CustomTextEditorView: View {
    
    @Binding var text: String
    var header: String
    var bottomPadding: CGFloat
    var width: CGFloat?
    
    var body: some View {
        
        VStack {
            TextField("", text: $text)
                .frame(width: width != nil ? (width!-20): (UIScreen.main.bounds.width - 120), height: 25)
                .font(.custom("Minecraft", size: 19))
                .padding(.bottom, 3)
                .foregroundStyle(.white)
                .placeholder(when: text.isEmpty) {
                    Text(header)
                        .foregroundColor(.gray)
                        .font(.custom("Minecraft", size: 19))
                }
                .offset(x: -10) // Adjust this value as needed
            
            
            Rectangle()
                .frame(width: width != nil ? (width) : (UIScreen.main.bounds.width - 100), height: 1)
                .foregroundStyle(.white)
                .padding(.bottom, 50)
        }.padding(.bottom, bottomPadding)
    }
}

#Preview {
    CustomTextEditorView(text: .constant("test"), header: "test", bottomPadding: 20)
}
