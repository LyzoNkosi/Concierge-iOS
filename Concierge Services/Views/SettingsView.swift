import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            if(loginViewModel.isLoggedIn) {
                List {
                    // 1
                    NavigationLink(destination: UserProfileView()){
                        HStack {
                            Image(systemName: "person")
                            Text("User Details")
                        }
                    }
                    // 2
                    HStack {
                        Image(systemName: "creditcard")
                        Text("Payment Methods")
                        Image(systemName: "chevron.right")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    // 2
                    HStack {
                        Image(systemName: "lock.rotation")
                        Text("Change Password")
                        Image(systemName: "chevron.right")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    // 3
                    HStack {
                        Image(systemName: "lock.doc")
                        Text("Privacy Policy")
                        Image(systemName: "chevron.right")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    // 4
                    HStack {
                        Image(systemName: "doc.badge.ellipsis")
                        Text("Terms of Service")
                        Image(systemName: "chevron.right")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    // 5
                    HStack {
                        Image(systemName: "info.circle")
                        Text("About")
                        Image(systemName: "chevron.right")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    // 6
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
            } else{
                LoginView()
            }
        }
    }
    
    /*fileprivate func LogoutButton() -> some View {
     Button(action: {
     Task {
     await loginViewModel.signOut()
     }
     }) {
     Text("Log Out")
     }
     }*/
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
