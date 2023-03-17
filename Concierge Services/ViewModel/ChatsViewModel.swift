import Foundation
import RealmSwift

class ChatsViewModel: ObservableObject{
    
    @Published var messages: [ChatMessage] = []
    
    func getChatMessages(firestoreManager: FirestoreManager) /*-> Results<ChatMessage>*/{
        let realm = try! Realm()
        
        var tempMessagesList: [ChatMessage] = []
        
        //return realm.objects(ChatMessage.self)
        let realChatMessages = realm.objects(ChatMessage.self).sorted(byKeyPath: "dateTime", ascending: true)
        
        for realmChatMessage in realChatMessages {
            tempMessagesList.append(realmChatMessage)
        }
        self.messages = tempMessagesList
    }
}
