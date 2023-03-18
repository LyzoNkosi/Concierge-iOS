import SwiftUI

struct TabbarView: View {
    
    @State var tabSelection: Tabs = .homeTab
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection) {
                
                VStack {
                    DashboardView().environmentObject(firestoreManager)
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(Tabs.homeTab)
                
                VStack {
                    TimelineView().environmentObject(firestoreManager)
                }
                .tabItem {
                    Image(systemName: "calendar.day.timeline.left")
                    Text("Timeline")
                }
                .tag(Tabs.timelineTab)
                
                VStack {
                    ChatView().environmentObject(firestoreManager)
                }
                .tabItem {
                    Image(systemName: "ellipsis.message")
                    Text("Chat")
                }
                .tag(Tabs.chatTab)
                
                VStack {
                    BalanceView().environmentObject(firestoreManager)
                }
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("Balance")
                }
                .tag(Tabs.balanceTab)
                
                VStack {
                    //SettingsView().environmentObject(firestoreManager)
                    SettingsScreenView().environmentObject(firestoreManager)
                }
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(Tabs.settingsTab)
            }
            .navigationBarTitle(returnNaviBarTitle(tabSelection: self.tabSelection))
        }
    }
    
    enum Tabs{
        case homeTab, timelineTab, chatTab, balanceTab, settingsTab
    }
    
    func returnNaviBarTitle(tabSelection: Tabs) -> String{
        switch tabSelection{
        case .homeTab: return "Home"
        case .timelineTab: return "Timeline"
        case .chatTab: return "Chat"
        case .balanceTab: return "Balance"
        case .settingsTab: return "Settings"
        }
    }
}

struct SettingsScreenView : View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    @ObservedObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        return VStack {
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
            }
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
