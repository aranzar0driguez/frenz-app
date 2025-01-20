//
//  ImageWithPromptView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/14/24.
//

import Foundation
import SwiftUI

struct ImageWithPromptView: View {
    
    var prompt: String
    var url: String? = nil
    
    var body: some View {
        
        ZStack (alignment: .bottom){
           
            
            if let imageURL = url, let imageURL = URL(string: imageURL) {
                
                VStack {
                    
                        EventRemoteImage(urlString: imageURL)
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width-5, height: UIScreen.main.bounds.height/1.4)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                }
                   
                
            }
            
            //  TODO: Make sure to change this to the comment that is above
            
//            VStack {
//                
//                Image("samplePic3")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: UIScreen.main.bounds.width-5, height: UIScreen.main.bounds.height/1.4)
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
//
//                
//            }
        
            Rectangle()
                .fill(Color.black)
                .frame(width: UIScreen.main.bounds.width-27, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.white, lineWidth: 1))
                .padding(.bottom, 15)
                

            Text("\(prompt)")
                .foregroundStyle(.white)
                .font(.custom("Minecraft", size: 13))
                .padding(.bottom, 20)
                .padding([.leading, .trailing])
                .multilineTextAlignment(.center)
                .frame(width: UIScreen.main.bounds.width-20, height: 70)

        }
        
        
    }
}


#Preview {
    ImageWithPromptView(prompt: "Me after studying 18 hours straight in bass")
}
