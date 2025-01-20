//
//  SignUpP2View.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/16/24.
//

import SwiftUI

struct SignUpP2View: View {
    
    @Binding var signUpPageIndex: Int
    @ObservedObject var signUpVM : SignUpViewModel

    
    var body: some View {
        
        GeometryReader { _ in
            ZStack {
                
                Color.black.edgesIgnoringSafeArea(.all)
                
                BackArrowButton(numOfPagesToGoBack: 1, signUpPageIndex: $signUpPageIndex, topPadding: 30, leadingPadding: 15)
                
                
                
                VStack {
                    HStack {
                        Text("My birthday is:")
                            .foregroundStyle(.white)
                            .font(.custom("Minecraft", size: 30))
                            .padding(.bottom, 20)
                        
                        Spacer()
                        
                    }
                    .frame(width: UIScreen.main.bounds.width - 100, height: 25)
                    .padding(.bottom, 60)
                    
                    BirthdayInputView(signUpPageIndex: $signUpPageIndex, signUpVM: signUpVM)
                        .padding(.bottom, 5)
                        
                        Text("*You will NOT be able to change this later")
                            .foregroundStyle(.white)
                            .font(.custom("Minecraft", size: 15))
                    
                }
                .padding(.bottom, UIScreen.main.bounds.height/3)
                
            }
        }.ignoresSafeArea(.keyboard, edges: .all)
       
    }
}

#Preview {
    SignUpP2View(signUpPageIndex: .constant(1), signUpVM: SignUpViewModel())
}


struct BirthdayInputView: View {
  
    @State private var month = ""
    @State private var day = ""
    @State private var year = ""
    @State private var birthday = Date()
    
    @Binding var signUpPageIndex: Int
    @ObservedObject var signUpVM : SignUpViewModel


    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
           
            
            HStack(spacing: 15) {
                
                birthdayField(placeholder: "MM", text: $month, maxLength: 2)
                
                Text("/")
                    .foregroundColor(.white)
                    .font(.custom("Minecraft", size: 22))
                
                birthdayField(placeholder: "DD", text: $day, maxLength: 2)

                Text("/")
                    .foregroundColor(.white)
                    .font(.custom("Minecraft", size: 22))

                
                birthdayField(placeholder: "YYYY", text: $year, maxLength: 4)

            }
            .font(.custom("Minecraft", size: 19))

            
            Button {
                
                validateAndSubmit()
                
                withAnimation(.spring()) {
                    signUpPageIndex += 1

                }
                
            } label : {
                NextButton(buttonText: "Next", textColor: .black, buttonColor: isValidInput ? .white : .gray, isDisabled: !isValidInput)
            }
            .disabled(!isValidInput)

            
            
        }
        .padding()
    }
    
    private func birthdayField(placeholder: String, text: Binding<String>, maxLength: Int) -> some View {
        
        VStack {
            ZStack(alignment: .leading) {
             
                if text.wrappedValue.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)  // White with some transparency
                        .font(.custom("Minecraft", size: 22))  // Match the TextField font
                        .frame(width: placeholder == "YYYY" ? 80 : 50)
                        .offset(x: -10) // Adjust this value as needed

                }
                
                TextField("", text: text)
                    .keyboardType(.numberPad)
                    .frame(width: placeholder == "YYYY" ? 75 : 45)
                    .onChange(of: text.wrappedValue) { newValue in
                        text.wrappedValue = String(newValue.prefix(maxLength))
                            .filter { "0123456789".contains($0) }
                    }
                    .foregroundColor(.white)  // This sets the color of the entered text
            }
            .frame(height: 30, alignment: .leading)  // Add a consistent height and center alignment

            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.white)
                .frame(width: placeholder == "YYYY" ? 80 : 50)

        }
    
    }
    
    private var isValidInput: Bool {
        let monthInt = Int(month) ?? 0
        let dayInt = Int(day) ?? 0
        let yearInt = Int(year) ?? 0
        
        return monthInt >= 1 && monthInt <= 12 &&
               dayInt >= 1 && dayInt <= 31 &&
               yearInt >= 1900 && yearInt <= Calendar.current.component(.year, from: Date()) - 15
    }
    
    private func validateAndSubmit() {
        guard isValidInput else { return }
        
        var dateComponents = DateComponents()
            dateComponents.year = Int(year)
            dateComponents.month = Int (month)
            dateComponents.day = Int (day)
        
            
        if let birthday = Calendar.current.date(from: dateComponents) {
            
            signUpVM.appUser.birthday = birthday
            
            let ageComponents = Calendar.current.dateComponents([.year], from: birthday, to: Date())
            
            signUpVM.appUser.age = ageComponents.year ?? 0
            
            
        }
        
    }
    
}
