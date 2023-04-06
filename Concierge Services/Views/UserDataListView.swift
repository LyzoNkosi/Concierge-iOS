//
//  UserDataListView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/06.
//

import SwiftUI

struct UserDataListView: View {
    
    var body: some View {
        
        VStack {
            List {
                // 1
                NavigationLink(destination: PersonalDetailsView()) {
                    HStack {
                        Image(systemName: "person")
                        Text("Personal Details")
                            .font(Font.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color.ColorPrimary)
                    }
                }
                // 2
                NavigationLink(destination: AddressView()) {
                    HStack {
                        Image(systemName: "house.fill")
                        Text("Address")
                            .font(Font.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color.ColorPrimary)
                    }
                }
                // 3
                NavigationLink(destination: EmergencyContactView()) {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text("Emergency Contact")
                            .font(Font.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color.ColorPrimary)
                    }
                }
                // 4
                NavigationLink(destination: AirlinePreferencesView()) {
                    HStack {
                        Image(systemName: "airplane")
                        Text("Airline Preferences")
                            .font(Font.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color.ColorPrimary)
                    }
                }
                // 
                NavigationLink(destination: SetActivitiesView()) {
                    HStack {
                        Image(systemName: "figure.disc.sports")
                        Text("Sporting Ativities")
                            .font(Font.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color.ColorPrimary)
                    }
                }
            }
        }
        
    }
    
}

struct UserDataListView_Previews: PreviewProvider {
    static var previews: some View {
        UserDataListView()
    }
}
