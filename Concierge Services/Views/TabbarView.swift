import SwiftUI

struct TabbarView: View {
    
    @State var tabSelection: Tabs = .homeTab
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection) {
                
                ScrollView {
                    VStack {
                        EmptyBoxImage()
                        
                        ChatButtonContent()
                            .onTapGesture {
                                tabSelection = .chatTab
                            }
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
                
                SettingsView().environmentObject(firestoreManager)
                
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
                    .tag(Tabs.settingsTab)
            }
            .navigationTitle(returnNaviBarTitle(tabSelection: self.tabSelection))
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

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
