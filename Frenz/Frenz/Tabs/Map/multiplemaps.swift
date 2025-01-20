//
//  multiplemaps.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/23/24.
//

import SwiftUI

struct multiplemaps: View {
    @State var index = 0
    
    @StateObject var mapViewModel = MapViewModel()
    @EnvironmentObject var profileVM: ProfileViewModel

    
    var body: some View {
        
        ZStack (alignment: .top){
            
            VStack {
                
                //  If ONLY friends, show friends first and then romantic
                TabView(selection: self.$index) {
                    
                    
                    if let purpose = profileVM.user?.appUtilizationPurpose {
                        
                        
                        if purpose == .friendsAndRomantic || purpose == .romantic {
                            mapView(mapViewModel: mapViewModel)
                                .tag(0)
                                .gesture(DragGesture())
                                .onAppear {
                                    mapViewModel.disableBottomButton = false
                                    mapViewModel.clickedOnAdmirers = true
                                }
                            
                        } else {
                            InaccessibleView(doNotShowAdmirers: true)
                                .tag(purpose == .friends ? 1 : 0)
                                .gesture(DragGesture())
                                .onAppear {
                                    mapViewModel.showFriendsFirst = true 
                                    mapViewModel.disableBottomButton = true
                                }
                        }
                        
                        if purpose == .friendsAndRomantic || purpose == .friends {
                            mapView(mapViewModel: mapViewModel)
                                .tag(purpose == .friends ? 0 : 1)
                                .gesture(DragGesture())
                                .onAppear {
                                    if purpose == .friends {
                                        mapViewModel.showFriendsFirst = true 
                                    }
                                    mapViewModel.clickedOnAdmirers = false 
                                    mapViewModel.disableBottomButton = false
                                }
                        } else {
                            InaccessibleView(doNotShowAdmirers: false)
                                .tag(1)
                                .gesture(DragGesture())
                                .onAppear {
                                    mapViewModel.disableBottomButton = true
                                }
                        }
                    }
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onAppear {
                      UIScrollView.appearance().isScrollEnabled = false
                }
                
            }
                // this blocks swipe

            .disabled(mapViewModel.show24HourWarningScreen || mapViewModel.isLoading ? true : false)
            
            .blur(radius: mapViewModel.show24HourWarningScreen ? 3.0 : 0)

            SlidingTabView(index: $index, keepHeader: false, mapViewModel: mapViewModel)
                .disabled(mapViewModel.show24HourWarningScreen || mapViewModel.isLoading ? true : false)
                .blur(radius: mapViewModel.show24HourWarningScreen ? 3.0 : 0)
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            //
            VStack {
                Spacer()
                HStack {
                    Spacer()
                
                    
                    MapButton(mapViewModel: mapViewModel, onMap: true)
                    
                }
            }
            .disabled(mapViewModel.show24HourWarningScreen || mapViewModel.disableBottomButton || mapViewModel.isLoading ? true : false)
            .blur(radius: mapViewModel.show24HourWarningScreen || mapViewModel.disableBottomButton ? 3.0 : 0)


            
            if mapViewModel.show24HourWarningScreen {
                TwentyFourHoursView(mapViewModel: mapViewModel)
            }
            
            Spacer()
            
            if mapViewModel.isLoading {
                
                VStack {
                    Spacer()
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(2)
                        .frame(maxWidth: 130, maxHeight: 38)
                    
                    Spacer()
                }
                
            }
            
        }
        .ignoresSafeArea()
        
    }
}
#Preview {
    multiplemaps()
}
