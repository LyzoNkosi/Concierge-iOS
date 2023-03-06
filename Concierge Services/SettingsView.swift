//
//  SettingsView.swift
//  Concierge Services
//
//  Created by Mac on 2023/03/03.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
            NavigationView {
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
                }
                .navigationTitle("Settings")
                .environment(\.defaultMinListRowHeight, 75)
            }
        }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
