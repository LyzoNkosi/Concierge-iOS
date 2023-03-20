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
                        .font(Font.custom("Poppins-Light", size: 10))
                }
                .tag(Tabs.homeTab)
                
                VStack {
                    TimelineView().environmentObject(firestoreManager)
                }
                
                .tabItem {
                    Image(systemName: "calendar.day.timeline.left")
                    Text("Timeline")
                        .font(Font.custom("Poppins-Light", size: 10))
                }
                .tag(Tabs.timelineTab)
                
                VStack {
                    ChatView().environmentObject(firestoreManager)
                }
                .tabItem {
                    Image(systemName: "ellipsis.message")
                    Text("Chat")
                        .font(Font.custom("Poppins-Light", size: 10))
                }
                .tag(Tabs.chatTab)
                
                ScrollView {
                    BalanceView().environmentObject(firestoreManager)
                }
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("Balance")
                        .font(Font.custom("Poppins-Light", size: 10))
                }
                .tag(Tabs.balanceTab)
                
                //SettingsView().environmentObject(firestoreManager)
                VStack {
                    List {
                        // 1
                        NavigationLink(destination: UserProfileView().environmentObject(firestoreManager)) {
                            HStack {
                                Image(systemName: "person")
                                Text("User Details")
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.TextColorPrimary)
                            }
                        }
                        // 2
                        NavigationLink(destination: PlaceholderView()){
                            HStack {
                                Image(systemName: "creditcard")
                                Text("Payment Methods")
                                Text("User Details")
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.TextColorPrimary)
                            }
                        }
                        // 3
                        NavigationLink(destination: PlaceholderView()){
                            HStack {
                                Image(systemName: "lock.rotation")
                                Text("Change Password")
                                Text("User Details")
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.TextColorPrimary)
                            }
                        }
                        // 4
                        NavigationLink(destination: PlaceholderView()){
                            HStack {
                                Image(systemName: "lock.doc")
                                Text("Privacy Policy")
                                Text("User Details")
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.TextColorPrimary)
                            }
                        }
                        // 5
                        NavigationLink(destination: PlaceholderView()){
                            HStack {
                                Image(systemName: "doc.badge.ellipsis")
                                Text("Terms of Service")
                                Text("User Details")
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.TextColorPrimary)
                            }
                        }
                        // 6
                        NavigationLink(destination: PlaceholderView()){
                            HStack {
                                Image(systemName: "info.circle")
                                Text("About")
                                Text("User Details")
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.TextColorPrimary)
                            }
                        }
                        // Admin
                        if(isKeyPresentInUserDefaults(key: "user_role") && UserDefaults.standard.value(forKey: "user_role") as! Int >= 2 ){
                            NavigationLink(destination: AdminTasksView().environmentObject(firestoreManager)){
                                HStack {
                                    Image(systemName: "gearshape")
                                    Text("Admin")
                                    Text("User Details")
                                        .font(Font.custom("Poppins-Regular", size: 16))
                                        .foregroundColor(Color.TextColorPrimary)
                                }
                            }
                        }
                        // 7
                        HStack {
                            Image(systemName: "pip.exit")
                            Text("Logout")
                            Text("User Details")
                                .font(Font.custom("Poppins-Regular", size: 16))
                                .foregroundColor(Color.TextColorPrimary)
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
                        .font(Font.custom("Poppins-Light", size: 10))
                }
                .tag(Tabs.settingsTab)
            }
            .navigationTitle(returnNaviBarTitle(tabSelection: self.tabSelection))
            .font(Font.custom("Poppins-Regular", size: 20))
        } else {
            LoginView().environmentObject(loginViewModel).environmentObject(firestoreManager)
        }
        
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
