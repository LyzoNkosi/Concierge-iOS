import SwiftUI

struct TabbarView: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    var body: some View {
        TabView {
            NavigationView {
                DashboardView().environmentObject(firestoreManager)
            }
            .tag(0)
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            NavigationView {
                TimelineView().environmentObject(firestoreManager)
            }
            .tag(1)
            .tabItem {
                Image(systemName: "calendar.day.timeline.left")
                Text("Timeline")
            }
            
            NavigationView {
                ChatView().environmentObject(firestoreManager)
            }
            .tag(2)
            .tabItem {
                Image(systemName: "ellipsis.message")
                Text("Chat")
            }
            
            NavigationView {
                BalanceView().environmentObject(firestoreManager)
            }
            .tag(3)
            .tabItem {
                Image(systemName: "creditcard")
                Text("Balance")
            }
            
            NavigationView {
                SettingsView().environmentObject(firestoreManager)
            }
            .tag(4)
            .tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }
            
        }
    }
}
