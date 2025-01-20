//
//  lookUpView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/15/24.
//

import SwiftUI

struct lookUpView: View {
    
    @EnvironmentObject var pViewModel : ProfileViewModel
    @EnvironmentObject var allUsers: AllOfUsers
    @State private var searchText = ""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                
                VStack(spacing: 0) {
                    
                    SearchBarView(text: $searchText)
                        .padding(.bottom, 15)
                        .padding(.top, -15)
                    
                    
                    if !searchText.isEmpty {
                        
                        ScrollView {
                            VStack(spacing: 0) {
                                
                                if !allUsers.searchedUsers.isEmpty {
                                    ForEach(allUsers.searchedUsers) { user in
                                        NavigationLink (value: user) {
                                            searchResult(user: user)
                                        }
                                    }
                                }
                                else {
                                    NavigationLink {
                                        
                                        //  Change to pview
                                        UserNotFoundRequestFormView()
                                           
                                    } label: {
                                        
                                        VStack {
                                            Text("Don't see the person you're searching for? 👀")
                                                .font(.custom("Minecraft", size: 14))
                                                .foregroundStyle(.white)
                                            
                                            Text("Click here! >")
                                                .underline()
                                                .font(.custom("Minecraft", size: 14))
                                                .foregroundStyle(.white)
                                        }
                                        
                                    }

                                }
                            }
                        }
                        .transition(.opacity)
                        
                    } else {
                        // Normal Grid View
                        
                        List {
                            LazyVGrid(columns: columns) {
                                
                                Section {
                                    ForEach(allUsers.limitedUsers) { user in
                                        
                                        lookUpCell(user: user)
                                            .padding(.bottom, 45)
                                    
                                        
                                        if user == allUsers.limitedUsers.last {
                                            HStack {
                                                AcceptButton(buttonText: "Load More", backgroundColor: allUsers.hasMoreUsers ? .green : .gray, width: 150, textColor: .white)
                                                    .foregroundStyle(.white)
                                                    .onTapGesture {
                                                        Task {
                                                            try await allUsers.getQueriedUsers(limit: 6)
                                                        }
                                                    }
                                                    .disabled(!allUsers.hasMoreUsers)
                                                
                                                Spacer()
                                            }
//
                                        }
                                        
                                    }
                                }.listRowBackground(Color.black)
                                .listRowInsets(EdgeInsets())
                            }
                            .padding(.bottom, 20)
                            
                        }
                        
                        
                        
                        .environment(\.colorScheme, .dark)
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        
                    }
                }
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                
            }
            
            .navigationDestination(for: user.self) { user in
                CardView(showAdmirersGifts: false, showGiftSendingOptions: false, user: user, updateCardView: false)
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    lookUpView()
}
