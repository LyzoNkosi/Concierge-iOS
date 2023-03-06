import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            NavigationView {
                TimelineView()
            }
            .tag(0)
            .tabItem {
                Image("home")
                    .resizable()
                Text("Timeline")
            }
            
            NavigationView {
                ChatView().environmentObject(ChatHelper())
            }
            .tag(1)
            .tabItem {
                Image("chat")
                Text("Chat")
            }
            
            NavigationView {
                     BalanceView()
                  }
                   .tag(2)
                    .tabItem {
                    Image("wallet")
                    Text("Balance")
                }
            
            NavigationView {
                     SettingsView()
                  }
                   .tag(2)
                    .tabItem {
                    Image("settings")
                    Text("Settings")
                }
            
        }
    }
}
