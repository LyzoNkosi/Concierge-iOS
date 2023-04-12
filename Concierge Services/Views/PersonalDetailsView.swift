//
//  PersonalDetailsView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/06.
//

import SwiftUI

struct PersonalDetailsView: View {
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var idNumber: String = ""
    @State var dob: String = ""
    @State var passportNumber: String = ""
    
    @State var buttonText: String = "Edit"
    
    @State var notInEditMode: Bool = true
    
    var body: some View {
        
        ScrollView {
            VStack {
                
                VStack(alignment: .leading, spacing: 24) {
                    ProfileImage()
                        .padding(16)
                }
                
                // Personal Details
                VStack(alignment: .leading) {
                    Label {
                        Text("Personal Details")
                            .font(Font.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image(systemName: "person.fill")
                            .foregroundColor(Color.Accent)
                    }
                    .padding()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("First Name")
                                .font(Font.custom("Poppins-Regular", size: 14))
                                .foregroundColor(Color.ColorPrimary)
                            FirstNameInput()
                        }
                        .padding()
                        
                        VStack(alignment: .leading) {
                            Text("Last Name")
                                .font(Font.custom("Poppins-Regular", size: 14))
                                .foregroundColor(Color.ColorPrimary)
                            LastNameInput()
                        }
                        .padding()
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        UserEmailInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("ID Number")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        
                        HStack {
                            NatRegInput()
                            Image("cloud_document")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .padding(2)
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Passport Number")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        
                        HStack {
                            PassportInput()
                            Image("cloud_document")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .padding(2)
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Date of Birth")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        DateOfBirthInput()
                    }
                    .padding()
                    
                }
                
            }
        }
        .toolbar {
            Button(self.buttonText) {
                if(self.notInEditMode) {
                    self.notInEditMode = true
                    self.buttonText = "Edit"
                } else {
                    self.notInEditMode = false
                    self.buttonText = "Save"
                }
            }
        }
        
    }
    
    fileprivate func FirstNameInput() -> some View {
        TextField(UserDefaultsUtils.shared.getUserFirstName(), text: $firstName)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(notInEditMode)
    }
    
    fileprivate func LastNameInput() -> some View {
        TextField(UserDefaultsUtils.shared.getUserLastName(), text: $lastName)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(notInEditMode)
    }
    
    fileprivate func UserEmailInput() -> some View {
        TextField(UserDefaultsUtils.shared.getUserEmail(), text: $email)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func NatRegInput() -> some View {
        TextField("ID Number", text: $idNumber)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func PassportInput() -> some View {
        TextField("Passport Number", text: $passportNumber)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func DateOfBirthInput() -> some View {
        TextField("Date of Birth", text: $dob)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
}

struct PersonalDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDetailsView()
    }
}
