//
//  WarningScreenViewModel.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 12/5/24.
//

import Foundation

@MainActor
final class WarningScreenViewModel: ObservableObject {
    
    @Published var showMainWarningScreen: Bool = false
    @Published var showSubWarningScreen: Bool = false
    @Published var mainMessage: String = ""
    @Published var subMessage: String = ""
    
}
