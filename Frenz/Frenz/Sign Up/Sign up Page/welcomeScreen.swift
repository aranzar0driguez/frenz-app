//
//  welcomeScreen.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/18/24.
//

import SwiftUI

struct welcomeScreen: View {
  
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        
                        Text("Frenz")
                            .font(.custom("Minecraft", size: 50))
                            .foregroundStyle(.white)
                        
                        Image("heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                        Text("Make new friends or meet someone special ; )")
                            .font(.custom("Minecraft", size: 20))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 15) {
                        NavigationLink(value: true) {
                            signingUpButton(buttonText: "Sign up")
                        }
                        
                        
                        
                        NavigationLink(value: false) {
                            signingUpButton(buttonText: "Log in")
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationDestination(for: Bool.self) { value in
                switch value {
                case true:
                    signInWithGoogleView(firstTimeUser: true)
                    
                case false:
                    signInWithGoogleView(firstTimeUser: false)

                default:
                    Text("Nothing")
                }
            }
        }
    }
}

#Preview {
    welcomeScreen()
}
