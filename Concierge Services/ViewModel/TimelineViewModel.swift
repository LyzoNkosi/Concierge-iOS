import Foundation
import RealmSwift

class TimelineViewModel: ObservableObject{
    
    @Published var tickets: [Ticket] = []
    
    func getTickets(firestoreManager: FirestoreManager) {
        var realmTickets: [Ticket] = []
        
        let realm = try! Realm()
        
        for realmTicket in realm.objects(Ticket.self) {
            realmTickets.append(realmTicket)
        }
        tickets = realmTickets
    }
}
