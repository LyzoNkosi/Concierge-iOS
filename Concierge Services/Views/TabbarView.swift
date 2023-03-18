import SwiftUI

struct TabbarView: View {
    
    @State var tabSelection: Tabs = .homeTab
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection) {
                
                    DashboardView().environmentObject(firestoreManager)
                
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(Tabs.homeTab)
                
                
                        TimelineView().environmentObject(firestoreManager)
                
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
                
                    SettingsView().environmentObject(firestoreManager)
                
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(Tabs.settingsTab)
            }
            //.navigationTitle(returnNaviBarTitle(tabSelection: self.tabSelection))
        }
    }
    
    enum Tabs {
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

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
