//
//  SignUpViewModel.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/17/24.
//

import Foundation
import SwiftUI
import _PhotosUI_SwiftUI

@MainActor
final class SignUpViewModel: ObservableObject {
    

    @Published var selectedImages: [UIImage] = [UIImage(resource: .no)]
    @Published var photoPickerItems: [PhotosPickerItem?] = [nil]

    @Published var selectedPrompt: String = ""

    
    @Published var appUser = user(firstName: "", lastName: "", email: "", age: 0, birthday: Date(), interests: [], friendBio: "", admirerBio: "", major: "", paths: [], imagesURL: [], latitude: 0.0, longitude: 0.0, attractedSex: nil, appUtilizationPurpose: nil, lookingFor: nil, selectedPicturePrompts: ["This will be your profile pic"], selectedWrittenPrompts: [], answeredWrittenPrompts: [], randomNum: 0, giftsReceived: [], messages: [], sex: nil, universityID: "", customField: "", admirersMapEmails: [], admirersCardsEmails: [], friendsMapEmails: [], friendsCardsEmails: [], fcmToken: "")
    
}
