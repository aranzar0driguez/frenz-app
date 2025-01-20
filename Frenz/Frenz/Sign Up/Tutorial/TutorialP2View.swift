//
//  TutorialP2View.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/17/24.
//

import SwiftUI

struct TutorialP2View: View {
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("You can see all users that are on the map!")
                    .font(.custom("Minecraft", size: 20))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center) 
                    .lineSpacing(10)
                
                
                
                //  Check out all of the users that are on app through the map!
                
                //  You can also select through randomized cards
                
                //  Feel free to also stalk that one person
                
                //  Lastly, You will be able to see who gave you gifts and chat with others
                
                //  One last thing! Your likes are currently viewable, but you can choose to remain anonymous in the settings. Let's go!
            }
        }
    }
}

#Preview {
    TutorialP2View()
}
