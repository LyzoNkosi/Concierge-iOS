//
//  TabBarView2.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/14.
//

import SwiftUI

struct TabBarView2: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @State var tabSelection: Tabs = .homeTab
    
    var body: some View {
        
        if(loginViewModel.isLoggedIn) {
            
            TabView(selection: $tabSelection) {
                
                // Tab 1
                VStack {
                    
                    TimelineView2()
                        .environmentObject(loginViewModel)
                    
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                        .font(Font.custom("Poppins-Light", size: 10))
                }
                .tag(Tabs.homeTab)
                .background(Color.white)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        VStack(alignment: .trailing) {
                            Image("african_sun_logo_no_bg")
                                .resizable()
                                .frame(width: 128, height: 112)
                            
                        }
                    }
                }
                .padding()
                
                // Tab 2
                VStack {
                    
                }
                .tabItem {
                    Image("keys_")
                        .resizable()
                        .font(.system(size: 16))
                    //.frame(width: 18, height: 18)
                    
                    Text("Concierge")
                        .font(Font.custom("Poppins-Light", size: 10))
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        VStack(alignment: .trailing) {
                            Image("african_sun_logo_no_bg")
                                .resizable()
                                .frame(width: 128, height: 112)
                            
                        }
                    }
                }
                .tag(Tabs.chatTab)
                
            }
            .navigationBarBackButtonHidden(true)
            
        } else {
            LoginView().environmentObject(loginViewModel).environmentObject(firestoreManager)
        }
    }
    
    enum Tabs {
        case homeTab, chatTab
    }
}

struct TabBarView2_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView2()
    }
}
