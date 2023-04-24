//
//  TimelineView2.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/14.
//

import SwiftUI

struct TimelineView2: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @StateObject var ticketsViewModel: TimelineViewModel = TimelineViewModel()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            NavigationLink (destination: SettingsView2().environmentObject(firestoreManager).environmentObject(loginViewModel)) {
                UserToolbarView()
                    .environmentObject(firestoreManager)
            }
            
            ScreenTitleView(screenTitle: "Timeline")
                .padding(.top, 0)
            
            List(ticketsViewModel.tickets) { ticket in
                CollapsibleView(
                    label: { TaskHeaderView(ticket: ticket) },
                    content: { TaskContentView(selectedTask: ticket, userId: UserDefaultsUtils().getUserId())}
                )
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity)
                
            }
            .padding(.top, 0)
            .listStyle(PlainListStyle())
            
            Spacer()
        }
        .onAppear {
            ticketsViewModel.getTickets()
        }
    }
}

struct TimelineView2_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView2()
            .environmentObject(FirestoreManager())
    }
}
