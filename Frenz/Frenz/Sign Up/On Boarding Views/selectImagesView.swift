//
//  selectImagesView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/17/24.
//

import SwiftUI
import PhotosUI

struct selectImagesView: View {

    var updatingProfile: Bool
    var userEmail: String?
    
    @Binding var signUpPageIndex: Int
    @ObservedObject var signUpVM : SignUpViewModel
    
    @State var isLoading = false
    @State var successfulUpdate = false
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
        
    ]
    
    
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            if !updatingProfile {
                BackArrowButton(numOfPagesToGoBack: 1, signUpPageIndex: $signUpPageIndex, topPadding: 30, leadingPadding: 15)
            }
            
            
            VStack {
                Text("Click on prompts to add images")
                    .foregroundStyle(.white)
                    .font(.custom("Minecraft", size: 19))
                    .padding(.bottom, 20)
                
                if successfulUpdate {
                    Text("Your profile has been successfully updated!")
                        .foregroundStyle(.red)
                        .font(.custom("Minecraft", size: 20))
                        .padding(.bottom, 20)
                    
                }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(signUpVM.appUser.selectedPicturePrompts.indices, id: \.self) { index in
                            let prompt = signUpVM.appUser.selectedPicturePrompts[index]
                            PhotosPicker(selection: $signUpVM.photoPickerItems[index], matching: .images, photoLibrary: .shared()) {
                             
                                //  If we are the the first index, go ahead and 
                                
                                imageRectangle(prompt: prompt, userSelectedImage: signUpVM.selectedImages[index])
                                    .padding(.bottom, 15)
                                
                            }
                        }
                        .onChange(of: signUpVM.photoPickerItems) { _ in
                            Task {
                                for (index, item) in signUpVM.photoPickerItems.enumerated() {
                                    if let item = item,
                                       let data = try? await item.loadTransferable(type: Data.self),
                                       let image = UIImage(data: data) {
                                        signUpVM.selectedImages[index] = image
                                    }
                                }
                            }
                        }
                    }
                }
                
                ZStack {
                    NextButtonBottom (action: {
                        
                        if !updatingProfile {
                            
                            withAnimation(.spring()) {
                                signUpPageIndex += 1
                            }
                            
                        }
                        else {
                            
                            guard let email = userEmail else {
                                return
                            }
                            
                        
                            
                            Task {
                                isLoading = true
                                //  Updates the prompts
                                
                                try await UserManager.shared.updateUserField(userEmail: email, signUpVM.appUser.selectedPicturePrompts, codingKeyRawValue: user.CodingKeys.selectedPicturePrompts.rawValue)
                                
                                //  deletes images from firebase
                                try await UserManager.shared.deleteUserImages(userEmail: email)
                                
                                for image in signUpVM.selectedImages {
                                    
                                    //  Updates new images to firebase
                                    try await UserManager.shared.uploadUserImages(uiImage: image, userEmail: email)
                                    
                                    print("successfully updated the images!")
                                    
                                }
                                
                                isLoading = false
                                
                                successfulUpdate = true
                            }
                            
                        }
                        // weird glitch where it didn't enable the button
                        
                        //  Might be that that there are more images (in the array) than the selected?
                    }, disabled: signUpVM.selectedImages.contains(where: { image in
                        image.isEqual(UIImage(resource: .no))
                    }) || isLoading, updatingProfile: updatingProfile)
                    
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            .scaleEffect(2)
                            .frame(maxWidth: 120, maxHeight: 30)
                    }
                }
                
            }
            
        }.navigationBarBackButtonHidden(isLoading)
        
    }
}

struct imageRectangle: View {
    
    
    var prompt: String
    var userSelectedImage: UIImage
    
    var body: some View {
            
            ZStack {
                
                
               
                
                
                Image(uiImage: userSelectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width/2.2, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.white, lineWidth: 3))
                
                Text(prompt)
                    .frame(width: UIScreen.main.bounds.width/2.2 - 10, height: 20)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .background(.black).opacity(0.75)
                    .font(.custom("Minecraft", size: 14))
                
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: UIScreen.main.bounds.width/2.2, height: 200)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.white, lineWidth: 3))
                
            }

    }
}
