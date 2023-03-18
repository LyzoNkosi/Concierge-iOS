import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var loginViewModel = LoginViewModel()
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    var body: some View {
        if(loginViewModel.isLoggedIn) {
            List {
                // 1
                NavigationLink(destination: UserProfileView().environmentObject(firestoreManager)){
                    HStack {
                        Image(systemName: "person")
                        Text("User Details")
                    }
                }
                // 2
                NavigationLink(destination: PlaceholderView()){
                    HStack {
                        Image(systemName: "creditcard")
                        Text("Payment Methods")
                    }
                }
                // 3
                NavigationLink(destination: PlaceholderView()){
                    HStack {
                        Image(systemName: "lock.rotation")
                        Text("Change Password")
                    }
                }
                // 4
                NavigationLink(destination: PlaceholderView()){
                    HStack {
                        Image(systemName: "lock.doc")
                        Text("Privacy Policy")
                    }
                }
                // 5
                NavigationLink(destination: PlaceholderView()){
                    HStack {
                        Image(systemName: "doc.badge.ellipsis")
                        Text("Terms of Service")
                    }
                }
                // 6
                NavigationLink(destination: PlaceholderView()){
                    HStack {
                        Image(systemName: "info.circle")
                        Text("About")
                    }
                }
                // Admin
                if(isKeyPresentInUserDefaults(key: "user_role") && UserDefaults.standard.value(forKey: "user_role") as! Int >= 2 ){
                    NavigationLink(destination: AdminTasksView().environmentObject(firestoreManager)){
                        HStack {
                            Image(systemName: "gearshape")
                            Text("Admin")
                        }
                    }
                }
                // 7
                HStack {
                    Image(systemName: "pip.exit")
                    Text("Logout")
                    Image(systemName: "chevron.right")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }.onTapGesture {
                    Task {
                        await loginViewModel.signOut()
                    }
                }
                //LogoutButton()
            }
            .navigationTitle("Settings")
            .environment(\.defaultMinListRowHeight, 50)
        } else {
            LoginView()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
