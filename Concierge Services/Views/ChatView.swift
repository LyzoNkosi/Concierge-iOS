import SwiftUI
import AlertToast

struct ChatView: View {
    @State var typingMessage: String = ""
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @ObservedObject var chatsViewModel: ChatsViewModel = ChatsViewModel()
    
    @ObservedObject private var keyboard = KeyboardResponder()
    
    @State private var showToast = false
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(chatsViewModel.messages) { chat in
                    MessageView(currentMessage: chat)
                }
                HStack {
                    TextField("Message...", text: $typingMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: CGFloat(30))
                    Button(action: sendMessage) {
                        Text("Send")
                    }
                }.frame(minHeight: CGFloat(50)).padding()
            }.navigationBarTitle(Text("Chat"), displayMode: .inline)
                .padding(.bottom, keyboard.currentHeight)
                .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading: .bottom)
                .onAppear{
                    chatsViewModel.getChatMessages(firestoreManager: firestoreManager)
                }
                .toast(isPresenting: $showToast){
                    
                    AlertToast(type: .regular, title: "Please type in a message")
                    
                }
        }.onTapGesture {
            self.endEditing(true)
        }
    }
    
    func sendMessage() {
        if(!typingMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty){
            //chatHelper.sendMessage(Message(content: typingMessage, user: DataSource.secondUser))
            let messageToSend = typingMessage.trimmingCharacters(in: .whitespacesAndNewlines)
            typingMessage = ""
            
            firestoreManager.sendChatMessage(messageText: messageToSend) { message in
                if(message != nil){
                    
                } else {
                    //chatsViewModel.getChatMessages(firestoreManager: firestoreManager)
                }
                
            }
        } else {
            
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
