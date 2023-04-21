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
            
            NavigationLink (destination: SettingsView().environmentObject(firestoreManager).environmentObject(loginViewModel)) {
                UserToolbarView()
                    .environmentObject(firestoreManager)
            }
            
            List(ticketsViewModel.tickets) { ticket in
                CollapsibleView(
                    label: { TaskHeaderView(ticket: ticket) },
                    content: { TaskContentView(selectedTask: ticket, userId: UserDefaultsUtils().getUserId())}
                )
                //.listRowInsets(EdgeInsets())
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

struct UserToolbarView : View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    let userDefaultUtils = UserDefaultsUtils()
    
    var body: some View {
        return VStack {
            let fullName = userDefaultUtils.getUserFirstName() + " " + userDefaultUtils.getUserLastName()
            
            /*Image(systemName: "person.circle")
             .font(.system(size: 24))
             .padding(4)*/
            
            Text(fullName)
                .font(Font.custom("Poppins-Bold", size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 24)
                .padding(.trailing, 24)
            
            Divider()
                .frame(height: 3)
                .overlay(Color.gray)
                .padding(.leading, 24)
                .padding(.trailing, 24)
        }
    }
}

struct TimelineView2_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView2()
            .environmentObject(FirestoreManager())
    }
}
