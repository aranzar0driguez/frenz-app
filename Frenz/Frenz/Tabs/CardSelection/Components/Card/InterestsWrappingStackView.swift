//
//  InterestsWrappingStackView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/14/24.
//

import SwiftUI
import WrappingHStack

struct InterestsWrappingStackView: View {
    
    var user: user
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("Interests")
                    .font(.custom("Minecraft", size: 22))
                    .foregroundStyle(.white)
                
                Image("thumbsUp")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
               
            }
            .padding(.bottom, 5)
            
            WrappingHStack(user.interests, spacing: WrappingHStack.Spacing.constant(10)) { interest in
                
                BubbleButton(interest: interest, color: .red)
                    .padding(.bottom, 5)
            }
            
            
        }
    }
}

#Preview {
    InterestsWrappingStackView(user: MockUser.fakeUser)
}
