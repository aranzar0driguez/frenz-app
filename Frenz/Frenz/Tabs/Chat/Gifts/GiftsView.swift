//
//  GiftsView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/15/24.
//

import SwiftUI

struct GiftsView: View {
    
    
    var body: some View {
        

        VStack {
            Spacer()
            Text("No convos here yet...send someone a gift to get some conversations going!")
                .foregroundStyle(.white)
                .font(.custom("Minecraft", size: 23))
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 15)
                .padding(.bottom, 20)
                .padding(.top, 100)
            
            Image("hourglass")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
            Spacer()
        }
        
        
        
        
    }
}

#Preview {
    GiftsView()
}
