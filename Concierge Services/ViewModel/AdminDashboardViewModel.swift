import Foundation
import RealmSwift

class AdminDashboardViewModel: ObservableObject{
    
    @Published var numberOfClients = 0
    
    func getNumberOfClients(firestoreManager: FirestoreManager) {
        let realm = try! Realm()
        
        self.numberOfClients = realm.objects(Client.self).count
    }
}
