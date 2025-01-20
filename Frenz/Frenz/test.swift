//
//  test.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/21/24.
//

import Foundation
import SwiftUI

struct test: View {
    
       var body: some View {
        
           HStack {
               Text("Loading your awesome profile...")
                   .foregroundStyle(.white)
                   .font(.custom("Minecraft", size: 17))
               
               Image("heart")
                   .resizable()
                   .scaledToFill()
                   .frame(width: 40, height: 40)
               
           }
           
    }
    
    
}

#Preview {
    test()
}
