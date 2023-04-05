//
//  ManagePreferencesView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/05.
//

import SwiftUI

struct ManagePreferencesView: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    @State var selectedClient: Client
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ManagePreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        ManagePreferencesView(selectedClient: Client(id: "", firstName: "", lastName: "")).environmentObject(FirestoreManager())
    }
}
