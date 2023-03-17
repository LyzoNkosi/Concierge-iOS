import Foundation
import RealmSwift

class ChatMessage: Object, Identifiable {
    @Persisted var id: String? = ""
    @Persisted var messageType: Int = 0
    @Persisted var message: String? = ""
    @Persisted var dateTime: String? = ""
    
    override init() {
        
    }
    
    init(id: String? = nil, messageType: Int, message: String? = nil, dateTime: String? = nil) {
        self.id = id
        self.messageType = messageType
        self.message = message
        self.dateTime = dateTime
    }
    
    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        return lhs.id == rhs.id
    }
}

enum MessageType: Int{
    case TYPE_SENT = 0
    case TYPE_RECEIVED = 1
}
