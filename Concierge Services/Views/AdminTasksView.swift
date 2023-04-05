import SwiftUI

struct AdminTasksView: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    var body: some View {
        
        VStack {
            
            List {
                // 1
                NavigationLink(destination: CreateAccountView().environmentObject(firestoreManager)){
                    HStack {
                        Image(systemName: "person.badge.plus")
                        Text("Create Account")
                            .font(Font.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color.ColorPrimary)
                    }
                }
                // 2
                NavigationLink(destination: UsersListView(selectedView: "Create Task").environmentObject(firestoreManager)){
                    HStack {
                        Image(systemName: "note.text.badge.plus")
                        Text("Create Task")
                            .font(Font.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color.ColorPrimary)
                    }
                }
                // 3
                NavigationLink(destination: UsersListView(selectedView: "Client Chat").environmentObject(firestoreManager)){
                    HStack {
                        Image(systemName: "message.badge")
                        Text("Client Chat")
                            .font(Font.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color.ColorPrimary)
                    }
                }
                // 4
                NavigationLink(destination: UsersListView(selectedView: "Manage Preferences").environmentObject(firestoreManager)){
                    HStack {
                        Image(systemName: "person.fill.questionmark")
                        Text("Manage Preferences")
                            .font(Font.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color.ColorPrimary)
                    }
                }
            }
        }
        .navigationBarTitle("Admin")
        .font(Font.custom("Poppins-Regular", size: 20))
        .environment(\.defaultMinListRowHeight, 50)
    }
}

struct AdminTasksView_Previews: PreviewProvider {
    static var previews: some View {
        AdminTasksView()
    }
}
