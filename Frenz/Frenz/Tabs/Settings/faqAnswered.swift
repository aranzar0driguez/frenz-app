//
//  faqAnswered.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 12/7/24.
//

import SwiftUI

struct faqAnswered: View {
    var body: some View {
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)

            VStack (spacing: 20){
                
                HStack {
                    Spacer()
                    
                    Text("FAQ")
                        .foregroundStyle(.white)
                        .font(.custom("Minecraft", size: 30))
                    
                    Spacer()
                }
                
                faqSection(question: "What is Frenz?", answer: "This is an app designed by a former Yale student, for Yale students. My goal is to provide you with a platform where you can meet other Yalies. Whether it be that Yale husband/wife you've always searched for or you simply want to meet other cool Yalies (like you), you've come to the right place! :}")
                    
                
                faqSection(question: "Why are there only two questions here?", answer: "I kind of finished this app in the middle of the night... so I'm really tired right now. But if there's any other questions or issues you're experiencing (or even suggestions on how to improve the app), you can reach me at: rodriguez.aranza.9801@gmail.com ")

                Spacer()
                
            }
            
        }
    }
}

#Preview {
    faqAnswered()
}
