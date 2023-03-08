//
//  SettingsView.swift
//  Concierge Services
//
//  Created by Mac on 2023/03/03.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            if(loginViewModel.isLoggedIn){
                List {
                    // 1
                    HStack {
                        Image("profile")
                        Text("User Details")
                        Image("chevron")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    // 2
                    HStack {
                        Image("credit card")
                        Text("Payment Methods")
                        Image("chevron")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    // 2
                    HStack {
                        Image("password")
                        Text("Change Password")
                        Image("chevron")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    // 3
                    HStack {
                        Image("privacy")
                        Text("Privacy Policy")
                        Image("chevron")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    // 4
                    HStack {
                        Image("terms")
                        Text("Terms of Service")
                        Image("chevron")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    // 5
                    HStack {
                        Image("about")
                        Text("About")
                        Image("chevron")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    // 6
                    /*HStack {
                        Image(systemName: "pip.exit")
                        Text("Logout")
                        Image("chevron")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }.onTapGesture {
                        Task {
                            await loginViewModel.signOut()
                        }
                    }*/
                    LogoutButton()
                }
                .navigationTitle("Settings")
                .environment(\.defaultMinListRowHeight, 50)
            } else{
                ContentView()
            }
        }
    }
    
    fileprivate func LogoutButton() -> some View {
        Button(action: {
            Task {
                await loginViewModel.signOut()
            }
        }) {
            Text("Log Out")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct LogoutButtonContent : View {
        var body: some View {
            return Text("Logout")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.red)
                .cornerRadius(15.0)
    }
}
