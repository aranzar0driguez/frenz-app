//
//  TextPromptView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/14/24.
//

import Foundation
import SwiftUI

struct TextPromptView: View {
    
    var prompt: String
    var userResponse: String
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 5){
            Text("\(prompt)")
                .font(.custom("Minecraft", size: 22))
                .padding(.bottom, 15)
            
            ZStack {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: UIScreen.main.bounds.width-27, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.white, lineWidth: 1))
                    .padding(.bottom, 15)
                
                
                Text("\(userResponse)")
                    .lineSpacing(4)
                    .foregroundStyle(.white)
                    .font(.custom("Minecraft", size: 14))
                    .padding(.bottom, 20)
                    .padding([.leading, .trailing])
                    .multilineTextAlignment(.leading)
                    .frame(width: UIScreen.main.bounds.width-20, height: 70, alignment: .leading)
            }
            
//            Text("\(userResponse)")
//                .font(.custom("Minecraft", size: 16))
//                .frame(width: UIScreen.main.bounds.width, height: 40)
            
            
           
        }
        .padding([.leading, .trailing], 15)
        .foregroundStyle(.white)
        .padding([.bottom], 20)

        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}


#Preview {
    TextPromptView(prompt: "You will never guess:", userResponse: "Test")
}
