import SwiftUI

struct ClientChatView: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @State var selectedClient: Client
    
    @State var typingMessage: String = ""
    @StateObject var chatsViewModel: ClientChatViewModel = ClientChatViewModel()
    @ObservedObject private var keyboard = KeyboardResponder()
    
    init(selectedClient: Client) {
        self.selectedClient = selectedClient
        
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(chatsViewModel.messages) { message in
                    ClientMessageView(currentMessage: message)
                }
                HStack {
                    TextField("Message...", text: $typingMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: CGFloat(30))
                    Button(action: sendMessage) {
                        Text("Send")
                    }
                }.frame(minHeight: CGFloat(50)).padding()
            }.navigationBarTitle(Text((selectedClient.firstName ?? "") + " " + (selectedClient.lastName ?? "")), displayMode: .inline)
                .padding(.bottom, keyboard.currentHeight)
                .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading: .bottom)
                .onAppear{
                    chatsViewModel.getClientChats(firestoreManager: firestoreManager, clientId: selectedClient.id!)
                }
        }.onTapGesture {
            self.endEditing(true)
        }
    }
    
    func sendMessage() {
        //chatHelper.sendMessage(Cha(content: typingMessage, user: DataSource.secondUser))
        typingMessage = ""
    }
}

struct ClientChatView_Previews: PreviewProvider {
    static var previews: some View {
        ClientChatView(selectedClient: Client(id: "", firstName: "", lastName: ""))
    }
}
