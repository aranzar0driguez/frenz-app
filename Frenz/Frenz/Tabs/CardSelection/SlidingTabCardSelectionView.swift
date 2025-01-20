//
//  SlidingTabCardSelectionView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/25/24.
//

import SwiftUI

struct SlidingTabCardSelectionView: View {
    
    @State var index = 0
    @StateObject var cardSelectionVM = MapViewModel()
    @EnvironmentObject var allUsers :  AllOfUsers
    @EnvironmentObject var profileVM: ProfileViewModel


    var body: some View {
        
        ZStack (alignment: .top){
            
            
            
            VStack {
                
            
                TabView(selection: self.$index) {
                    
               
                    
                    if let purpose = profileVM.user?.appUtilizationPurpose {
                        
                        if purpose == .friendsAndRomantic || purpose == .romantic {
                            
                            CarouselUserCardsView(carouselUserVM: cardSelectionVM, users: allUsers.admirersCards)
                                .tag(0)
                                .onAppear {
                                    cardSelectionVM.disableBottomButton = false
                                    cardSelectionVM.clickedOnAdmirers = true

                                }
                            
                        } else {
                            
                            InaccessibleView(doNotShowAdmirers: true)
                                .tag(purpose == .friends ? 1 : 0)
                                .onAppear {
                                    cardSelectionVM.showFriendsFirst = true
                                    cardSelectionVM.disableBottomButton = true
                                }
                            
                        }
                        
                        if purpose == .friendsAndRomantic || purpose == .friends {
                            
                            CarouselUserCardsView(carouselUserVM: cardSelectionVM, users: allUsers.friendsCards)
                                .tag(purpose == .friends ? 0 : 1)
                                .onAppear {
                                    if  purpose == .friends {
                                        
                                        cardSelectionVM.showFriendsFirst = true
                                    }
                                    cardSelectionVM.clickedOnAdmirers = false
                                    cardSelectionVM.disableBottomButton = false
                                }
                            
                        } else {
                            
                            InaccessibleView(doNotShowAdmirers: false)
                                .tag(1)
                                .onAppear {
                                    cardSelectionVM.disableBottomButton = true
                                }
                            
                        }
                    }
                }
                
            }
            .disabled(cardSelectionVM.show24HourWarningScreen || cardSelectionVM.isLoading ? true : false)
            .blur(radius: cardSelectionVM.show24HourWarningScreen ? 3.0 : 0)
            
            SlidingTabView(index: $index, keepHeader: false, mapViewModel: cardSelectionVM)
                .disabled(cardSelectionVM.show24HourWarningScreen || cardSelectionVM.isLoading ? true : false)
                .blur(radius: cardSelectionVM.show24HourWarningScreen ? 3.0 : 0)
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            
            
            VStack {
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    MapButton(mapViewModel: cardSelectionVM, onMap: false)
                }
                
            }
            .disabled(cardSelectionVM.show24HourWarningScreen || cardSelectionVM.disableBottomButton || cardSelectionVM.isLoading ? true : false )
            .blur(radius: cardSelectionVM.show24HourWarningScreen ? 3.0 : 0)
            .blur(radius: cardSelectionVM.disableBottomButton ? 3.0 : 0)
            
            if cardSelectionVM.show24HourWarningScreen {
                TwentyFourHoursView(mapViewModel: cardSelectionVM)
            }
            
            Spacer()
            
            if cardSelectionVM.isLoading {
                
                VStack {
                    Spacer()
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2)
                        .frame(maxWidth: 120, maxHeight: 70)
                        .background(.black.opacity(0.35))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    
                    Spacer()
                }
                
            }
                           
        }.ignoresSafeArea()

       
        
    }
}

#Preview {
    SlidingTabCardSelectionView()
}
