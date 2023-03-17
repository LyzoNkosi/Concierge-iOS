import Foundation
import RealmSwift

class ChatsViewModel: ObservableObject{
    
    func getChatMessages(firestoreManager: FirestoreManager) -> Results<ChatMessage>{
        let realm = try! Realm()
        return realm.objects(ChatMessage.self)
    }
}
