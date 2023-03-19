import SwiftUI
import AlertToast

struct UsersListView: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @StateObject var usersViewModel: ClientsViewModel = ClientsViewModel()
    
    @State var selectedView: String
    
    @State var refreshing: Bool = false
    
    @State private var showToast = false
    @State private var toastMessage = ""
    
    var body: some View {
        
        VStack {
            
            switch(selectedView) {
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
                    
                    let fullName = (client.firstName ?? "") + " " + (client.lastName ?? "")
                    
                    /*HStack {
                     NavigationLink(destination: CreateTaskView(selectedClient: client).environmentObject(firestoreManager)){
                     HStack {
                     Image(systemName: "person")
                     
                     Text(fullName)
                     }
                     }
                     .navigationTitle("Create Task")
                     }.padding(8)*/
                    
                    HStack {
                        NavigationLink(destination: ClientTicketsView(selectedClient: client).environmentObject(firestoreManager)){
                            HStack {
                                Image(systemName: "person")
                                
                                Text(fullName)
                            }
                        }
                        .navigationTitle("Create Task")
                    }.padding(8)
                    
                }
                /*.refreshable {
                    if(!refreshing) {
                        refreshClients()
                    } else {
                        self.toastMessage = "Refresh already in progress"
                        self.showToast = true
                    }
                }*/
                
            case "Client Chat":
                List(usersViewModel.clients) { client in
                    
                    let fullName = (client.firstName ?? "") + " " + (client.lastName ?? "")
                    
                    HStack {
                        NavigationLink(destination: ClientChatView(selectedClient: client).environmentObject(firestoreManager)){
                            HStack {
                                Image(systemName: "person")
                                
                                Text(fullName)
                            }
                        }
                        .navigationTitle("Chat")
                    }.padding(8)
                    
                }
                /*.refreshable {
                    if(!refreshing) {
                        refreshClients()
                    } else {
                        self.toastMessage = "Refresh already in progress"
                        self.showToast = true
                    }
                }*/
                
            default:
                EmptyView()
                
            }
        }
        .toast(isPresenting: $showToast) {
            AlertToast(type: .regular, title: toastMessage)
        }
        .onAppear {
            refreshRealmClients()
        }
    }
    
    private func refreshRealmClients() {
        usersViewModel.getClients(firestoreManager: firestoreManager) { clientsLoaded in
            if(clientsLoaded) {
                self.refreshing = false
            } else {
                print("Error refreshing clients")
                
                self.toastMessage = "Error refreshing clients, please try again"
                self.showToast = true
                
                self.refreshing = false
            }
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView(selectedView: "Create Task")
    }
}
