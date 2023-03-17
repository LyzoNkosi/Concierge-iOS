import Foundation
import RealmSwift

class ChatsViewModel: ObservableObject{
    
    @Published var messages: [ChatMessage] = []
    
    func getChatMessages(firestoreManager: FirestoreManager) /*-> Results<ChatMessage>*/{
        let realm = try! Realm()
        //return realm.objects(ChatMessage.self)
        let realChatMessages = realm.objects(ChatMessage.self).sorted(byKeyPath: "dateTime", ascending: true)
        
        for realmChatMessage in realChatMessages {
            messages.append(realmChatMessage)
        }
        
    }
}
