//
//  RootView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/14/24.
//

import Foundation
import SwiftUI

struct RootView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool?
    @StateObject var allUsers = AllOfUsers()
    @StateObject var university = UniversityViewModel()
    @StateObject var warningScreenVM = WarningScreenViewModel()
    @State var isLoading = true
    
    
    var body: some View {
        
        
        ZStack {
            //  Background
            Color.black.edgesIgnoringSafeArea(.all)
            
                
                Group {
                    
                    if let currentUserFinishedLoading = currentUserSignedIn {
                        
                        if currentUserFinishedLoading {
                            SignedInTabsView(warningScreenVM: warningScreenVM)
                                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
                            
                        }
                        else {
                            welcomeScreen()
                                .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
                        }
                    }
                    
                    else {
                        welcomeScreen()
                            .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
                    }
                    
                
            }

        }
        .fullScreenCover(isPresented: $warningScreenVM.showMainWarningScreen, content: {
            MainWarningScreenView(message: warningScreenVM.mainMessage)
        })
        .animation(.spring, value: currentUserSignedIn)
        .environmentObject(allUsers)
        .environmentObject(university)

        .onAppear {
            
            Task {

                if let result = await GetUserAppVersionCloudFunction().getUserAppVersion() {
                    warningScreenVM.showMainWarningScreen = result.showMainWarningScreen
                    warningScreenVM.showSubWarningScreen = result.showSubWarningScreen
                    warningScreenVM.mainMessage = result.mainMessage
                    warningScreenVM.subMessage = result.subMessage
                }
                
                isLoading = false
            }

        }
        
    }
}


#Preview {
    RootView()
}
