//
//  UserToolbarView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/24.
//

import SwiftUI

struct UserToolbarView : View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    let userDefaultUtils = UserDefaultsUtils()
    
    var body: some View {
        return VStack(spacing: 0) {
            let fullName = userDefaultUtils.getUserFirstName() + " " + userDefaultUtils.getUserLastName()
            
            /*Image(systemName: "person.circle")
             .font(.system(size: 24))
             .padding(4)*/
            
            Text(fullName)
                .font(Font.custom("Poppins-Bold", size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 24)
                .padding(.trailing, 24)
                .padding(.top, 4)
                .padding(.bottom, 0)
            
            Divider()
                .frame(height: 3)
                .overlay(Color.gray)
                .padding(.leading, 24)
                .padding(.trailing, 24)
                .padding(.top, 0)
        }
        .padding(.bottom, 0)
    }
}

struct UserToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        UserToolbarView()
    }
}
