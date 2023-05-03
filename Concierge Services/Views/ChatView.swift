import SwiftUI

struct ChatView: View {
    @State var typingMessage: String = ""
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @ObservedObject var chatsViewModel: ChatsViewModel = ChatsViewModel()
    
    @ObservedObject private var keyboard = KeyboardResponder()
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink (destination: SettingsView2().environmentObject(firestoreManager).environmentObject(loginViewModel)) {
                UserToolbarView()
                    .environmentObject(firestoreManager)
            }
            
            ScreenTitleView(screenTitle: "Concierge")
            
            List(chatsViewModel.messages) { chat in
                MessageView(currentMessage: chat)
            }
            .padding(.top, 0)
            .listStyle(PlainListStyle())
            
            HStack {
                TextField("Message...", text: $typingMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(30))
                Button(action: sendMessage) {
                    Text("Send")
                        .font(Font.custom("Poppins-Regular", size: 16))
                        
                    
                    
                }
            }.frame(minHeight: CGFloat(50)).padding()
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                HeaderLogo()
            }
        }
        //.padding(.bottom, keyboard.currentHeight)
        //.edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading: .bottom)
        .onAppear {
            chatsViewModel.getChatMessages(firestoreManager: firestoreManager)
        }
        .onTapGesture {
            self.endEditing(true)
        }
    }
    
    func sendMessage() {
        if(!typingMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
            //chatHelper.sendMessage(Message(content: typingMessage, user: DataSource.secondUser))
            let messageToSend = typingMessage.trimmingCharacters(in: .whitespacesAndNewlines)
            typingMessage = ""
            
            firestoreManager.sendChatMessage(messageText: messageToSend) { message in
                if(message != nil){
                    
                } else {
                    //chatsViewModel.getChatMessages(firestoreManager: firestoreManager)
                }
                
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView().environmentObject(FirestoreManager()).environmentObject(LoginViewModel())
    }
}
