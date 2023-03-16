import Foundation
import RealmSwift

class ClientsViewModel: ObservableObject{
    
    //@Published var clients: [Client] = [Client(id: "1234567890", firstName: "Mary", lastName: "Jane"),
    //                                    Client(id: "112233445566", firstName: "Spokes", lastName: "H")]
    
    func getClients(firestoreManager: FirestoreManager) -> Results<Client>{
        let realm = try! Realm()
        return realm.objects(Client.self)
    }
}
