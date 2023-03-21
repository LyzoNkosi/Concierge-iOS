import Foundation
import RealmSwift

class Ticket: Object, Identifiable {
    @Persisted var id: String? = ""
    @Persisted var name: String? = ""
    @Persisted var startDate: String? = ""
    @Persisted var status: Int = TicketStatus.STATUS_NOT_STARTED.rawValue
    
    override init() {
        
    }
    
    init(id: String? = nil, name: String? = nil, startDate: String? = nil, status: Int = TicketStatus.STATUS_NOT_STARTED.rawValue) {
        self.id = id
        self.name = name
        self.startDate = startDate
        self.status = status
    }
}

enum TicketStatus: Int {
    case STATUS_NOT_STARTED = 0
    case STATUS_IN_PROGRESS = 1
    case STATUS_COMPLETE = 2
    case STATUS_RECURRING = 3
    case STATUS_CANCELLED = 4
}
