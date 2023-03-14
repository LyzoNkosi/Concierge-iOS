import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            NavigationView {
                DashboardView()
            }
            .tag(0)
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            NavigationView {
                TimelineView()
            }
            .tag(1)
            .tabItem {
                Image(systemName: "calendar.day.timeline.left")
                Text("Timeline")
            }
            
            NavigationView {
                ChatView().environmentObject(ChatHelper())
            }
            .tag(2)
            .tabItem {
                Image(systemName: "ellipsis.message")
                Text("Chat")
            }
            
            NavigationView {
                BalanceView()
            }
            .tag(3)
            .tabItem {
                Image(systemName: "creditcard")
                Text("Balance")
            }
            
            NavigationView {
                SettingsView()
            }
            .tag(4)
            .tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }
            
        }
    }
}
