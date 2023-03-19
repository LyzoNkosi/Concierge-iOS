import Foundation
import RealmSwift

class ClientsViewModel: ObservableObject{
    
    @Published var clients: [Client] = []
    
    func getClients(firestoreManager: FirestoreManager, clientsLoaded: @escaping (Bool) -> ()) {
        let realm = try! Realm()
        var realmClients: [Client] = []
        
        for client in realm.objects(Client.self) {
            realmClients.append(client)
        }
        
        clientsLoaded(true)
        self.clients = realmClients
    }
}
