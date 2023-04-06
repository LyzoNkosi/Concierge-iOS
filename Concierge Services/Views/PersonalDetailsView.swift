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
    
    @State var inEditMode: Bool = false
    
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
                        
                        VStack(alignment: .leading) {
                            Text("Last Name")
                                .font(Font.custom("Poppins-Regular", size: 14))
                                .foregroundColor(Color.ColorPrimary)
                            LastNameInput()
                        }
                        
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        UserEmailInput()
                    }
                    .padding()
                    
                }
                
            }
        }
        .toolbar {
            Button(self.buttonText) {
                if(self.inEditMode) {
                    self.inEditMode = false
                    self.buttonText = "Edit"
                } else {
                    self.inEditMode = true
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
            .disabled(inEditMode)
    }
    
    fileprivate func LastNameInput() -> some View {
        TextField(UserDefaultsUtils.shared.getUserLastName(), text: $lastName)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(inEditMode)
    }
    
    fileprivate func UserEmailInput() -> some View {
        TextField(UserDefaultsUtils.shared.getUserEmail(), text: $email)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(inEditMode)
    }
    
}

struct PersonalDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDetailsView()
    }
}
