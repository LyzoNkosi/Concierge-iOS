import Foundation
import RealmSwift

class ClientChatViewModel: ObservableObject{
    
    @Published var messages: [ChatMessage] = []
    
    func getClientChats(firestoreManager: FirestoreManager, clientId: String) {
        firestoreManager.getClientChatMessages(clientId: clientId) { messageList in
            self.messages = messageList.sorted { $0.dateTime! < $1.dateTime! }
        }
    }
}
