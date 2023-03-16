import Foundation
import RealmSwift

class TimelineViewModel: ObservableObject{
    
    func getTickets(firestoreManager: FirestoreManager) -> Results<Ticket>{
        let realm = try! Realm()
        return realm.objects(Ticket.self)
    }
}
