//
//  UserPreferencesView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/05.
//

import SwiftUI

struct UserPreferencesView: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading, spacing: 24) {
                ProfileImage()
                    .padding(24)
            }
            
            FirstNameInput()
            
            LastNameInput()
            
            UserEmailInput()
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .navigationTitle("Profile")
    }
    
    fileprivate func FirstNameInput() -> some View {
        TextField(UserDefaultsUtils.shared.getUserFirstName(), text: $firstName)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .padding()
            .disabled(true)
    }
    
    fileprivate func LastNameInput() -> some View {
        TextField(UserDefaultsUtils.shared.getUserLastName(), text: $lastName)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .padding()
            .disabled(true)
    }
    
    fileprivate func UserEmailInput() -> some View {
        TextField(UserDefaultsUtils.shared.getUserEmail(), text: $email)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .padding()
            .disabled(true)
    }
}

struct UserPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        UserPreferencesView().environmentObject(FirestoreManager())
    }
}
