//
//  SettingsView2.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/24.
//

import SwiftUI

struct SettingsView2: View {
    
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @Environment(\.presentationMode) var settingsPresentation
    
    @State private var showToast = false
    @State private var toastMessage = ""
    
    var body: some View {
        
        VStack {
            
            UserToolbarView()
                .environmentObject(firestoreManager)
            
            ScreenTitleView(screenTitle: "User Profile")
                .padding(.top, 0)
            
            List {
                // 1
                NavigationLink(destination: UserDataListView().environmentObject(firestoreManager)) {
                    HStack {
                        Image(systemName: "person")
                        Text("Personal Information")
                            .font(Font.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color.ColorPrimary)
                    }
                }
                // 2
                NavigationLink(destination: BalanceView()) {
                    HStack {
                        Image("credit_card")
                            .resizable()
                            .frame(width: 24, height: 18)
                            .padding(2)
                        
                        Text("Payment Methods")
                            .font(Font.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color.ColorPrimary)
                    }
                }
                // 3
                NavigationLink(destination: ChangePasswordView()) {
                    HStack {
                        Image("change_password")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(2)
                        
                        Text("Change Password")
                            .font(Font.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color.ColorPrimary)
                    }
                }
                .navigationBarTitle("")
                .environment(\.defaultMinListRowHeight, 50)
            }
            .border(Color.ColorPrimary)
            //.padding(.top, 0)
            .padding()
            .listStyle(PlainListStyle())
            
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                HeaderLogo()
            }
        }
    }
    
}

struct SettingsView2_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView2()
            .environmentObject(FirestoreManager())
            .environmentObject(LoginViewModel())
    }
}
