//
//  CreateTaskViewView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/03/16.
//

import SwiftUI

struct CreateTaskView: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @State var selectedClient: Client
    
    var body: some View {
        Text("Create Task")
    }
}

struct CreateTaskViewView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView(selectedClient: Client(id: "", firstName: "", lastName: ""))
    }
}
