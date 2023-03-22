import SwiftUI
import AlertToast

struct TabbarView: View {
    @State var tabSelection: Tabs = .homeTab
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @ObservedObject var dashboardViewModel: DashboardViewModel = DashboardViewModel()
    @ObservedObject var adminDashboardViewModel: AdminDashboardViewModel = AdminDashboardViewModel()
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @Environment(\.presentationMode) var settingsPresentation
    
    @State private var showToast = false
    @State private var toastMessage = ""
    
    var body: some View {
        
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
        
        if(loginViewModel.isLoggedIn) {
            TabView(selection: $tabSelection) {
                
                ScrollView {
                    
                    VStack {
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            
                            if(isKeyPresentInUserDefaults(key: "user_role") && UserDefaults.standard.value(forKey: "user_role") as! Int >= 2 ) {
                                
                                // 1
                                ZStack {
                                    Rectangle()
                                        .frame(width: 170, height: 170)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color.ColorPrimary, Color.ColorSecondary]), startPoint: .top, endPoint: .bottom))
                                        .cornerRadius(30)
                                    
                                    VStack() {
                                        Text("You have")
                                            .font(Font.custom("Poppins-Light", size: 20))
                                            .padding(2)
                                            .foregroundColor(Color.TextColorPrimary)
                                        
                                        Text(String(adminDashboardViewModel.numberOfClients))
                                            .padding(2)
                                            .font(Font.custom("Poppins-Medium", size: 24))
                                            .foregroundColor(Color.TextColorPrimary)
                                        
                                        Text("clients")
                                            .padding(2)
                                            .font(Font.custom("Poppins-Light", size: 16))
                                            .foregroundColor(Color.TextColorPrimary)
                                    }
                                }
                                
                                // 2
                                ZStack {
                                    Rectangle()
                                        .frame(width: 170, height: 170)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color.ColorPrimary, Color.ColorSecondary]), startPoint: .top, endPoint: .bottom))
                                        .cornerRadius(30)
                                    
                                    VStack() {
                                        Text("You've created")
                                            .font(Font.custom("Poppins-Light", size: 20))
                                            .padding(2)
                                            .foregroundColor(Color.TextColorPrimary)
                                        
                                        Text("10")
                                            .padding(2)
                                            .font(Font.custom("Poppins-Medium", size: 24))
                                            .foregroundColor(Color.TextColorPrimary)
                                        
                                        Text("tasks")
                                            .padding(2)
                                            .font(Font.custom("Poppins-Light", size: 16))
                                            .foregroundColor(Color.TextColorPrimary)
                                    }
                                }
                                
                                // Not admin
                            } else {
                                // 1
                                ZStack {
                                    Rectangle()
                                        .frame(width: 170, height: 170)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color.ColorPrimary, Color.ColorSecondary]), startPoint: .top, endPoint: .bottom))
                                        .cornerRadius(30)
                                    
                                    VStack() {
                                        Text("You have")
                                            .font(Font.custom("Poppins-Light", size: 20))
                                            .padding(2)
                                            .foregroundColor(Color.TextColorPrimary)
                                        
                                        Text(String(dashboardViewModel.numberOfPendingTasks))
                                            .padding(2)
                                            .font(Font.custom("Poppins-Medium", size: 24))
                                            .foregroundColor(Color.TextColorPrimary)
                                        
                                        Text("upcoming tasks")
                                            .padding(2)
                                            .font(Font.custom("Poppins-Light", size: 16))
                                            .foregroundColor(Color.TextColorPrimary)
                                    }
                                }
                                
                                // 2
                                ZStack {
                                    Rectangle()
                                        .frame(width: 170, height: 170)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color.ColorPrimary, Color.ColorSecondary]), startPoint: .top, endPoint: .bottom))
                                        .cornerRadius(30)
                                    
                                    VStack() {
                                        Text("Your balance")
                                            .font(Font.custom("Poppins-Light", size: 20))
                                            .padding(2)
                                            .foregroundColor(Color.TextColorPrimary)
                                        
                                        Text("R123.45")
                                            .padding(2)
                                            .font(Font.custom("Poppins-Medium", size: 24))
                                            .foregroundColor(Color.TextColorPrimary)
                                        
                                        let calendar = Calendar.current
                                        let date1 = calendar.startOfDay(for: Date.now)
                                        let date2 = calendar.startOfDay(for: Date().getThisMonthEnd() ?? Date.now)
                                        let components = calendar.dateComponents([.day], from: date1, to: date2)
                                        
                                        Text("due in " + String(components.day ?? 0) + " days")
                                            .padding(2)
                                            .font(Font.custom("Poppins-Light", size: 16))
                                            .foregroundColor(Color.TextColorPrimary)
                                    }
                                }
                            }
                            
                        }
                        .padding(.horizontal)
                    }
                    .cornerRadius(12)
                    
                }
                .safeAreaInset(edge: .bottom) {
                    
                    if(isKeyPresentInUserDefaults(key: "user_role") && UserDefaults.standard.value(forKey: "user_role") as! Int >= 2 ) {
                        NavigationLink(destination: AdminTasksView().environmentObject(firestoreManager)) {
                            AdminButtonContent()
                                .padding(8)
                        }
                        
                    } else {
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
                .safeAreaInset(edge: .bottom) {
                    
                    PayButtonContent()
                        .onTapGesture {
                            self.toastMessage = "This feature is coming soon"
                            self.showToast = true
                        }
                        .padding(8)
                    
                }
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("Balance")
                        .font(Font.custom("Poppins-Light", size: 10))
                }
                .tag(Tabs.balanceTab)
                
                //SettingsView().environmentObject(firestoreManager)
                /*
                 Start Settings Screen
                 */
                VStack {
                    List {
                        // 1
                        NavigationLink(destination: UserProfileView().environmentObject(firestoreManager)) {
                            HStack {
                                Image(systemName: "person")
                                Text("User Details")
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.ColorPrimary)
                            }
                        }
                        // 2
                        NavigationLink(destination: PlaceholderView()) {
                            HStack {
                                Image(systemName: "creditcard")
                                Text("Payment Methods")
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.ColorPrimary)
                            }
                        }
                        // 3
                        NavigationLink(destination: PlaceholderView()) {
                            HStack {
                                Image(systemName: "lock.rotation")
                                Text("Change Password")
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.ColorPrimary)
                            }
                        }
                        // 4
                        NavigationLink(destination: PlaceholderView()) {
                            HStack {
                                Image(systemName: "lock.doc")
                                Text("Privacy Policy")
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.ColorPrimary)
                            }
                        }
                        // 5
                        NavigationLink(destination: PlaceholderView()) {
                            HStack {
                                Image(systemName: "doc.badge.ellipsis")
                                Text("Terms of Service")
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.ColorPrimary)
                            }
                        }
                        // 6
                        NavigationLink(destination: PlaceholderView()) {
                            HStack {
                                Image(systemName: "info.circle")
                                Text("About")
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.ColorPrimary)
                            }
                        }
                        // Admin
                        if(isKeyPresentInUserDefaults(key: "user_role") && UserDefaults.standard.value(forKey: "user_role") as! Int >= 2 ) {
                            NavigationLink(destination: AdminTasksView().environmentObject(firestoreManager)) {
                                HStack {
                                    Image(systemName: "gearshape")
                                    Text("Admin")
                                        .font(Font.custom("Poppins-Regular", size: 16))
                                        .foregroundColor(Color.ColorPrimary)
                                }
                            }
                        }
                        // 7
                        HStack {
                            Image(systemName: "pip.exit")
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
                
                /*
                 End Settings Screen
                 */
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                        .font(Font.custom("Poppins-Light", size: 10))
                }
                .tag(Tabs.settingsTab)
            }
            .onAppear {
                dashboardViewModel.getNumberOfTickets(firestoreManager: firestoreManager)
                adminDashboardViewModel.getNumberOfClients(firestoreManager: firestoreManager)
            }
            .toast(isPresenting: $showToast) {
                AlertToast(type: .regular, title: toastMessage,
                           style: AlertToast.AlertStyle.style(backgroundColor: Color.ColorPrimary, titleColor: Color.TextColorPrimary, subTitleColor: Color.TextColorPrimary, titleFont: Font.custom("Poppins-Regular", size: 12), subTitleFont: Font.custom("Poppins-Light", size: 12)))
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
            .font(Font.custom("Poppins-Medium", size: 18))
            .foregroundColor(Color.TextColorPrimary)
            .padding()
            .frame(width: 220, height: 60)
            .background(LinearGradient(gradient: Gradient(colors: [Color.ColorPrimary, Color.ColorSecondary]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(15.0)
    }
}

struct AdminButtonContent : View {
    var body: some View {
        return Text("Admin")
            .font(Font.custom("Poppins-Medium", size: 18))
            .foregroundColor(Color.TextColorPrimary)
            .padding()
            .frame(width: 220, height: 60)
            .background(LinearGradient(gradient: Gradient(colors: [Color.ColorPrimary, Color.ColorSecondary]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(15.0)
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
