//
//  LongTextEditorView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/16/24.
//

import SwiftUI

struct LongTextEditor: View {
    
    var textHeader: String
    @Binding var fieldText: String
    let characterLimit = 250
    var emptyFieldHolder: String
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                TextEditor(text: $fieldText)
                    .font(.custom("Minecraft", size: 16))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.white, lineWidth: 3))
                    .frame(width: UIScreen.main.bounds.width-20, height: 200)
                    .onChange(of: fieldText) { newValue in
                        if newValue.count > characterLimit {
                            fieldText = String(newValue.prefix(characterLimit))
                        }
                    }
                
                if fieldText.isEmpty {
                    Text(emptyFieldHolder)
                        .foregroundColor(.gray)
                        .font(.custom("Minecraft", size: 16))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                }
            }
            .background(Color.black)
            
            Text("\(fieldText.count)/\(characterLimit) characters")
                .foregroundColor(.gray)
                .font(.custom("Minecraft", size: 12))
                .frame(width: UIScreen.main.bounds.width-20, alignment: .trailing)
        }
        .colorScheme(.dark)
    }

    
}

#Preview {
    LongTextEditor(textHeader: "TextHeader", fieldText: .constant(""), emptyFieldHolder: "empty")
}
