//
//  MapViewModel.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/15/24.
//

import Foundation

@MainActor
final class MapViewModel: ObservableObject {
    
    @Published var showCardViewSheet = false 
    @Published var selectedUser : user? 
    @Published var clickedOnAdmirers : Bool?  
    @Published var show24HourWarningScreen = false
    @Published var comeBackTime = Date()
    @Published var disableBottomButton = false 
    @Published var showFriendsFirst = false 
    @Published var isLoading = false 
}
