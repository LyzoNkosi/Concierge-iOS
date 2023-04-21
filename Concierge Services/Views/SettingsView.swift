//
//  SettingsView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/14.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @Environment(\.presentationMode) var settingsPresentation
    
    @State private var showToast = false
    @State private var toastMessage = ""
    
    var body: some View {
        VStack {
            
            UserToolbarView()
                .padding()
                .environmentObject(firestoreManager)
            
            List {
                // 1
                NavigationLink(destination: UserDataListView().environmentObject(firestoreManager)) {
                    HStack {
                        Image(systemName: "person")
                        Text("User Data")
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
                // 4
                NavigationLink(destination: PrivacyPolicyView()) {
                    HStack {
                        Image("privacy_policy")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(2)
                        
                        Text("Privacy Policy")
                            .font(Font.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color.ColorPrimary)
                    }
                }
                // 5
                NavigationLink(destination: TermsOfServiceView()) {
                    HStack {
                        Image("terms_of_service")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(2)
                        
                        Text("Terms of Service")
                            .font(Font.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color.ColorPrimary)
                    }
                }
                // 6
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("about")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(2)
                        
                        Text("About")
                            .font(Font.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color.ColorPrimary)
                    }
                }
                // Admin
                if(UserDefaultsUtils.shared.isUserAdmin()) {
                    NavigationLink(destination: AdminTasksView().environmentObject(firestoreManager)) {
                        HStack {
                            Image("settings")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding(2)
                            
                            Text("Admin")
                                .font(Font.custom("Poppins-Regular", size: 16))
                                .foregroundColor(Color.ColorPrimary)
                        }
                    }
                }
                // 7
                HStack {
                    Image("logout")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(2)
                    
                    Text("Logout")
                        .font(Font.custom("Poppins-Regular", size: 16))
                        .foregroundColor(Color.ColorPrimary)
                    Image(systemName: "chevron.right")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }.onTapGesture {
                    Task {
                        await loginViewModel.signOut()
                        self.settingsPresentation.wrappedValue.dismiss()
                    }
                }
                .navigationBarTitle("Settings")
                .environment(\.defaultMinListRowHeight, 50)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                VStack(alignment: .trailing) {
                    Image("african_sun_logo_no_bg")
                        .resizable()
                        .frame(width: 128, height: 112)
                        .padding(.top, 8)
                    
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(FirestoreManager())
            .environmentObject(LoginViewModel())
    }
}
