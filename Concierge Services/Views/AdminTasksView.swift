import SwiftUI

struct AdminTasksView: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    var body: some View {
        NavigationView {
            List {
                // 1
                NavigationLink(destination: CreateAccountView().environmentObject(firestoreManager)){
                    HStack {
                        Image(systemName: "person.badge.plus")
                        Text("Create Account")
                    }
                }
                // 2
                NavigationLink(destination: UsersListView(selectedView: "Create Task").environmentObject(firestoreManager)){
                    HStack {
                        Image(systemName: "note.text.badge.plus")
                        Text("Create Task")
                    }
                }
                // 3
                NavigationLink(destination: UsersListView(selectedView: "Client Chat").environmentObject(firestoreManager)){
                    HStack {
                        Image(systemName: "message.badge")
                        Text("Client Chat")
                    }
                }
            }
            .navigationTitle("Admin")
            .environment(\.defaultMinListRowHeight, 50)
        }
    }
}

struct AdminTasksView_Previews: PreviewProvider {
    static var previews: some View {
        AdminTasksView()
    }
}