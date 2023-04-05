//
//  UserPreferencesView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/05.
//

import SwiftUI

struct UserPreferencesView: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @State var placeholderText: String = "Placeholder"
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var idNumber: String = ""
    @State var dob: String = ""
    @State var passportNumber: String = ""
    
    
    
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
                    
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        UserEmailInput()
                    }
                    .padding()
                    
                }
                
                // Address
                VStack(alignment: .leading) {
                    
                    Label {
                        Text("Address")
                            .font(Font.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image(systemName: "house.fill")
                            .foregroundColor(Color.Accent)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Street Address")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        PlaceholderInput()
                    }
                    .padding()
                    
                }
                
                // Next of Kin
                VStack(alignment: .leading) {
                    
                    Label {
                        Text("Emergency Contact")
                            .font(Font.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image(systemName: "phone.fill")
                            .foregroundColor(Color.Accent)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Contact Person")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        PlaceholderInput()
                    }
                    .padding()
                    
                }
                
                // Airline Prefs
                VStack(alignment: .leading) {
                    
                    Label {
                        Text("Airline Preferences")
                            .font(Font.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image(systemName: "airplane")
                            .foregroundColor(Color.Accent)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Airline")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        PlaceholderInput()
                    }
                    .padding()
                }
                
                // Hotel Prefs
                VStack(alignment: .leading) {
                    
                    Label {
                        Text("Hotel Preferences")
                            .font(Font.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image(systemName: "building.2.fill")
                            .foregroundColor(Color.Accent)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Hotel Chain")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        PlaceholderInput()
                    }
                    .padding()
                    
                }
                
                // Car & Taxi Prefs
                VStack(alignment: .leading) {
                    
                    Label {
                        Text("Hotel Preferences")
                            .font(Font.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image(systemName: "car.fill")
                            .foregroundColor(Color.Accent)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Street Address")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        PlaceholderInput()
                    }
                    .padding()
                    
                }
                
                // Activities
                VStack(alignment: .leading) {
                    
                    Label {
                        Text("Activity Preferences")
                            .font(Font.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image(systemName: "figure.disc.sports")
                            .foregroundColor(Color.Accent)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Activity")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        PlaceholderInput()
                    }
                    .padding()
                    
                }
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        }
        .navigationTitle("Profile")
    }
    
    fileprivate func PlaceholderInput() -> some View {
        TextField("Placeholder", text: $placeholderText)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    // Personal Details
    fileprivate func FirstNameInput() -> some View {
        TextField(UserDefaultsUtils.shared.getUserFirstName(), text: $firstName)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func LastNameInput() -> some View {
        TextField(UserDefaultsUtils.shared.getUserLastName(), text: $lastName)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
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
    
    //
}

struct UserPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        UserPreferencesView().environmentObject(FirestoreManager())
    }
}
