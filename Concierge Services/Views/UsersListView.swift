import SwiftUI

struct UsersListView: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @StateObject var usersViewModel: ClientsViewModel = ClientsViewModel()
    
    @State var selectedView: String
    
    var body: some View {
        
        switch(selectedView){
        case "Create Task":
            /*ForEach(usersViewModel.clients) { client in
             HStack {
             NavigationLink(destination: CreateTaskView(client).environmentObject(firestoreManager)){
             HStack {
             Image(systemName: "person")
             
             let fullName = usersViewModel.clients[index].firstName + " " + usersViewModel.clients[index].lastName
             
             Text(fullName)
             }
             }
             }.padding(8)
             }*/
            
            List(usersViewModel.clients) { client in
                
                let fullName = client.firstName + " " + client.lastName
                
                HStack {
                    NavigationLink(destination: CreateTaskView(selectedClient: client).environmentObject(firestoreManager)){
                        HStack {
                            Image(systemName: "person")
                            
                            Text(fullName)
                        }
                    }
                    .navigationTitle("Create Task")
                }.padding(8)
                
            }
            
        case "Client Chat":
            List(usersViewModel.clients) { client in
                
                let fullName = client.firstName + " " + client.lastName
                
                HStack {
                    NavigationLink(destination: ClientChatView(selectedClient: client).environmentObject(ChatHelper()).environmentObject(firestoreManager)){
                        HStack {
                            Image(systemName: "person")
                            
                            Text(fullName)
                        }
                    }
                    .navigationTitle("Chat")
                }.padding(8)
                
            }
            
        default:
            EmptyView()
            
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView(selectedView: "Create Task")
    }
}
