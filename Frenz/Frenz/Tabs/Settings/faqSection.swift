//
//  faqSection.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 12/7/24.
//

import SwiftUI

struct faqSection: View {
    
    var question: String
    var answer: String
    
    var body: some View {
        
        VStack (alignment: .leading){
            Text("\(question)")
                .foregroundStyle(.white)
                .font(.custom("Minecraft", size: 20))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .padding(.bottom, 4)
            
            Text("\(answer)")
                .foregroundStyle(.white)
                .font(.custom("Minecraft", size: 15))
        }
        .frame(width: UIScreen.main.bounds.width - 15, alignment: .leading)
    }
}

#Preview {
    faqSection(question: "Why are there only two questions here omg idk?", answer: "this is the answer to the question")
}
