import SwiftUI
import AlertToast

struct TabbarView: View {
    @State var tabSelection: Tabs = .homeTab
    
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @Environment(\.presentationMode) var settingsPresentation
    
    @State private var showToast = false
    @State private var toastMessage = ""
    
    var body: some View {
        
        if(loginViewModel.isLoggedIn) {
            TabView(selection: $tabSelection) {
                
                ScrollView {
                    
                    if (UserDefaultsUtils().isUserAdmin()) {
                        AdminDashboardView()
                    } else {
                        UserDashboardView()
                    }
                    
                }
                .safeAreaInset(edge: .bottom) {
                    
                    if(UserDefaultsUtils.shared.isUserAdmin() ) {
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
                
                /*
                 Start Settings Screen
                 */
                VStack {
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
                        NavigationLink(destination: PlaceholderView()) {
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
                        NavigationLink(destination: PlaceholderView()) {
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
            .toast(isPresenting: $showToast) {
                AlertToast(type: .regular, title: toastMessage,
                           style: AlertToast.AlertStyle.style(backgroundColor: Color.ColorPrimary, titleColor: Color.TextColorPrimary, subTitleColor: Color.TextColorPrimary, titleFont: Font.custom("Poppins-Regular", size: 12), subTitleFont: Font.custom("Poppins-Light", size: 12)))
            }
            .navigationTitle(returnNaviBarTitle(tabSelection: self.tabSelection))
            .navigationBarBackButtonHidden(true)
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

struct AdminDashboardView : View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    @ObservedObject var adminDashboardViewModel: AdminDashboardViewModel = AdminDashboardViewModel()
    
    var body: some View {
        return VStack {
            
            LazyVGrid(columns: columns, spacing: 20) {
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
            }
            .padding(.horizontal)
            
        }//end
        .onAppear {
            adminDashboardViewModel.getNumberOfClients()
        }
        .cornerRadius(12)
    }
}

struct UserDashboardView : View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    @ObservedObject var dashboardViewModel: DashboardViewModel = DashboardViewModel()
    
    var body: some View {
        return VStack {
            
            LazyVGrid(columns: columns, spacing: 20) {
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
            .padding(.horizontal)
            
        }//end
        .cornerRadius(12)
        .onAppear {
            dashboardViewModel.getNumberOfTickets()
        }
    }
}
/*
 End Dashboard Content
 */

struct TabbarView_Previews: PreviewProvider {
    static let loginViewModel = LoginViewModel()
    static let firestoreManager = FirestoreManager()
    
    static var previews: some View {
        TabbarView()
            .environmentObject(loginViewModel)
            .environmentObject(firestoreManager)
    }
}
