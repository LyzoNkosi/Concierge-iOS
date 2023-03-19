import SwiftUI

struct TabbarView: View {
    
    @State var tabSelection: Tabs = .homeTab
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @Environment(\.presentationMode) var settingsPresentation
    
    var body: some View {
        //NavigationView {
        if(loginViewModel.isLoggedIn) {
            TabView(selection: $tabSelection) {
                
                ScrollView {
                    
                    VStack {
                        EmptyBoxImage()
                        
                        
                    }
                    .safeAreaInset(edge: .bottom) {
                        ChatButtonContent()
                            .onTapGesture {
                                tabSelection = .chatTab
                            }
                            .padding(8)
                    }
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
                
                ScrollView {
                    BalanceView().environmentObject(firestoreManager)
                }
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("Balance")
                }
                .tag(Tabs.balanceTab)
                
                //SettingsView().environmentObject(firestoreManager)
                VStack {
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
                                self.settingsPresentation.wrappedValue.dismiss()
                            }
                        }
                        //.navigationTitle("Settings")
                        .navigationBarTitle("Settings")
                        .environment(\.defaultMinListRowHeight, 50)
                    }
                }
                
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
                    .tag(Tabs.settingsTab)
            }
            .navigationTitle(returnNaviBarTitle(tabSelection: self.tabSelection))
        } else {
            LoginView().environmentObject(loginViewModel).environmentObject(firestoreManager)
        }
        //}
    }
    
    enum Tabs {
        case homeTab, timelineTab, chatTab, balanceTab, settingsTab
    }
    
    func returnNaviBarTitle(tabSelection: Tabs) -> String {
        switch tabSelection{
        case .homeTab: return "Home"
        case .timelineTab: return "Timeline"
        case .chatTab: return "Chat"
        case .balanceTab: return "Balance"
        case .settingsTab: return "Settings"
        }
    }
}

/*
 Start Dashboard Content
 */
struct EmptyBoxImage : View {
    
    var body: some View {
        return Image("empty_box")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 196, height: 196)
            .clipped()
            .padding(.bottom, 75)
    }
}

struct ChatButtonContent : View {
    var body: some View {
        return Text("Chat with Agent")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(primaryBlack)
            .cornerRadius(15.0)
    }
}

/*
 End Dashboard Content
 */

/*
 Start Settings View
 */

/*
 End Settings View
 */

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
