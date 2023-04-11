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
                
                List(usersViewModel.clients) { client in
                    
                    HStack {
                        NavigationLink(destination: ClientTicketsView(selectedClient: client).environmentObject(firestoreManager)){
                            HStack {
                                Image(systemName: "person")
                                
                                Text(getClientFullName(client: client))
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.ColorPrimary)
                            }
                        }
                        .navigationTitle("Create Task")
                    }.padding(8)
                    
                }
                
            case "Client Chat":
                List(usersViewModel.clients) { client in
                    
                    HStack {
                        NavigationLink(destination: ClientChatView(selectedClient: client).environmentObject(firestoreManager)){
                            HStack {
                                Image(systemName: "person")
                                
                                Text(getClientFullName(client: client))
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.ColorPrimary)
                            }
                        }
                        .navigationTitle("Chat")
                    }.padding(8)
                    
                }
                
            case "Manage Preferences":
                List(usersViewModel.clients) { client in
                    
                    HStack {
                        NavigationLink(destination: ManagePreferencesView(selectedClient: client).environmentObject(firestoreManager)) {
                            HStack {
                                Image(systemName: "person")
                                
                                Text(getClientFullName(client: client))
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.ColorPrimary)
                            }
                        }
                        .navigationTitle("Chat")
                    }.padding(8)
                    
                }
                
            case "User Data":
                Text("")
                List(usersViewModel.clients) { client in
                    
                    HStack {
                        NavigationLink(destination: UserPreferencesView(selectedClient: client).environmentObject(firestoreManager)){
                            HStack {
                                Image(systemName: "person")
                                
                                Text(getClientFullName(client: client))
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.ColorPrimary)
                            }
                        }
                        .navigationTitle("Manage User Data")
                    }.padding(8)
                    
                }
                
            default:
                EmptyView()
                
            }
        }
        .toast(isPresenting: $showToast) {
            AlertToast(type: .regular, title: toastMessage,
                       style: AlertToast.AlertStyle.style(backgroundColor: Color.ColorPrimary, titleColor: Color.TextColorPrimary, subTitleColor: Color.TextColorPrimary, titleFont: Font.custom("Poppins-Regular", size: 12), subTitleFont: Font.custom("Poppins-Light", size: 12)))
        }
        .onAppear {
            refreshRealmClients()
        }
    }
    
    private func getClientFullName(client: Client) -> String {
        return (client.firstName ?? "") + " " + (client.lastName ?? "")
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
