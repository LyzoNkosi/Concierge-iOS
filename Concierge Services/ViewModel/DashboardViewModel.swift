import Foundation
import RealmSwift

class DashboardViewModel: ObservableObject{
    
    @Published var numberOfPendingTasks = 0
    
    func getNumberOfTickets(firestoreManager: FirestoreManager) {
        let realm = try! Realm()
        
        for task in realm.objects(Ticket.self) {
            if(
                task.status == TicketStatus.STATUS_NOT_STARTED.rawValue ||
                task.status == TicketStatus.STATUS_COMPLETE.rawValue ||
                task.status == TicketStatus.STATUS_CANCELLED.rawValue
            ) {
                numberOfPendingTasks += 1
            }
        }
    }
}
