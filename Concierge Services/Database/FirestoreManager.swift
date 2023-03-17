import Firebase
import FirebaseFirestore
import RealmSwift

class FirestoreManager: ObservableObject{
    
    @Published var someStr: String = ""
    
    func fetchUserDetails(userID: String) {
        let database = Firestore.firestore()
        let defaults = UserDefaults.standard
        
        let userRef = database.collection("users").document(userID)
        
        userRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    defaults.set(data["first_name"] as? String ?? "", forKey: "first_name")
                    defaults.set(data["last_name"] as? String ?? "", forKey: "last_name")
                    defaults.set(data["role"] as? Int ?? "", forKey: "user_role")
                    
                    defaults.synchronize()
                }
            }
            
        }
    }
    
    func addNewUser(userId: String, firstName: String, lastName: String){
        let database = Firestore.firestore()
        
        let data: [String: Any] = ["first_name" : firstName,
                                   "last_name" : lastName,
                                   "role" : 1]
        
        let ref = database.collection("users").document(userId)
        ref.setData(data){ error in
            if let error = error{
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
    
    func getTickets(){
        let database = Firestore.firestore()
        
        do{
            let realm = try Realm()
            let objectsToDelete = realm.objects(Ticket.self)
            
            try! realm.write{
                realm.delete(objectsToDelete)
            }
            
            database.collection("tickets").document(UserDefaults.standard.value(forKey: "firebase_uid") as! String).collection("tickets").getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in querySnapshot!.documents {
                        
                        let ticket = Ticket(
                            id: document.documentID,
                            name: document["ticket_name"] as? String ?? "",
                            startDate: document["start_date"] as? String ?? "",
                            status: document["ticket_status"] as! Int)
                        
                        try! realm.write{
                            realm.add(ticket)
                        }
                        //print("\(document.documentID): \(document.data())")
                    }
                }
            }
        } catch let realmError as NSError{
            print("error - \(realmError.localizedDescription)")
        }
    }
    
    /*func getClientTickets(clientId: String) -> [Ticket] {
     let database = Firestore.firestore()
     
     var ticketsToReturn: [Ticket] = []
     
     database.collection("tickets").document(clientId).collection("tickets").getDocuments() { (querySnapshot, error) in
     if let error = error {
     print("Error getting documents: \(error)")
     } else {
     var tickets: [Ticket] = []
     
     for document in querySnapshot!.documents {
     
     let ticket = Ticket(id: document.documentID, name: document["ticket_name"] as? String ?? "", status: document["ticket_status"] as! Int)
     
     tickets.append(ticket)
     }
     ticketsToReturn = tickets
     }
     }
     return ticketsToReturn
     }*/
    
    func getClientTickets(clientId: String, loadedTickets:@escaping ([Ticket]) -> ()){
        let database = Firestore.firestore()
        
        database.collection("tickets").document(clientId).collection("tickets").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                loadedTickets([])
            } else {
                var ticketsToReturn: [Ticket] = []
                for document in querySnapshot!.documents {
                    
                    let ticket = Ticket(
                        id: document.documentID,
                        name: document["ticket_name"] as? String ?? "",
                        startDate: document["start_date"] as? String ?? "",
                        status: document["ticket_status"] as! Int)
                    ticketsToReturn.append(ticket)
                }
                loadedTickets(ticketsToReturn)
            }
        }
    }
    
    func getAgentClientTickets(finished: @escaping (String) -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            print("Getting your client tickets")
            finished("Ticket values go here")
        }
    }
    
    func createTicket(clientId: String, ticket: Ticket){
        let database = Firestore.firestore()
        
        let data: [String: Any] = ["ticket_name" : ticket.name!,
                                   "ticket_status" : TicketStatus.STATUS_NOT_STARTED]
        
        let ref = database.collection("tickets").document(clientId).collection("tickets").document()
        
        ref.setData(data){ error in
            if let error = error{
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func getAgentClients(){
        let database = Firestore.firestore()
        
        do{
            let realm = try Realm()
            let clientsToDelete = realm.objects(Client.self)
            
            try! realm.write{
                realm.delete(clientsToDelete)
            }
            
            database.collection("agent_clients").document(UserDefaults.standard.value(forKey: "firebase_uid") as! String).collection("clients").getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in querySnapshot!.documents {
                        let userRef = database.collection("users").document(document.documentID)
                        
                        userRef.getDocument { (userDocument, userError) in
                            guard userError == nil else {
                                print("error", userError ?? "")
                                return
                            }
                            
                            if let userDoc = userDocument, userDoc.exists {
                                let userData = userDoc.data()
                                if let userData = userData {
                                    let client = Client(
                                        id: document.documentID,
                                        firstName: userData["first_name"] as? String ?? "",
                                        lastName: userData["last_name"] as? String ?? "")
                                    
                                    try! realm.write{
                                        realm.add(client)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch let realmError as NSError{
            print("error - \(realmError.localizedDescription)")
        }
    }
    
    func getClientChatMessages(clientId: String, loadedMessages:@escaping ([ChatMessage]) -> ()){
        let database = Firestore.firestore()
        
        database.collection("chats").document(clientId).collection("messages").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var chatsToReturn: [ChatMessage] = []
                for document in querySnapshot!.documents {
                    //print("\(document.documentID): \(document.data())")
                    let message: ChatMessage = ChatMessage(
                        id: document.documentID,
                        messageType: document["type"] as! Int,
                        message: document["message"] as? String,
                        dateTime: document["timestamp"] as? String)
                    
                    chatsToReturn.append(message)
                    
                }
                loadedMessages(chatsToReturn)
            }
        }
    }
    
    func sendClientChatMessage(clientId: String, messageText: String, messageSent: @escaping (ChatMessage?) -> ()){
        let database = Firestore.firestore()
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: now)
        
        let data: [String: Any] = ["type" : MessageType.TYPE_RECEIVED.rawValue,
                                   "message" : messageText,
                                   "timestamp" : dateString]
        
        let ref = database.collection("chats").document(clientId).collection("messages").document()
        let messageId = ref.documentID
        
        ref.setData(data){ error in
            if let error = error{
                print("Error writing document: \(error)")
                messageSent(nil)
            } else {
                print("Document successfully written!")
                
                let message = ChatMessage(
                    id: messageId,
                    messageType: MessageType.TYPE_RECEIVED.rawValue,
                    message: messageText,
                    dateTime: dateString)
                
                messageSent(message)
            }
        }
    }
    
    func sendChatMessage(messageText: String, messageSent: @escaping (ChatMessage?) -> ()){
        let database = Firestore.firestore()
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: now)
        
        let data: [String: Any] = ["type" : MessageType.TYPE_SENT.rawValue,
                                   "message" : messageText,
                                   "timestamp" : dateString]
        
        let ref = database.collection("chats").document(UserDefaults.standard.value(forKey: "firebase_uid") as! String).collection("messages").document()
        
        let messageId = ref.documentID
        
        ref.setData(data){ error in
            if let error = error{
                print("Error writing document: \(error)")
                messageSent(nil)
            } else {
                print("Document successfully written!")
                
                let message = ChatMessage(
                    id: messageId,
                    messageType: MessageType.TYPE_SENT.rawValue,
                    message: messageText,
                    dateTime: dateString)
                
                self.updateLocalMessageStore(message: message)
                
                messageSent(message)
            }
        }
    }
    
    private func updateLocalMessageStore(message: ChatMessage){
        do{
            let realm = try Realm()
            
            try! realm.write{
                realm.add(message)
            }
            
        } catch let realmError as NSError{
            print("error - \(realmError.localizedDescription)")
        }
    }
    
    func getMyChatMessages(){
        let database = Firestore.firestore()
        
        do{
            let realm = try Realm()
            let messagesToDelete = realm.objects(ChatMessage.self)
            
            try! realm.write{
                realm.delete(messagesToDelete)
            }
            
            database.collection("chats").document(UserDefaults.standard.value(forKey: "firebase_uid") as! String).collection("messages").getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in querySnapshot!.documents {
                        //print("\(document.documentID): \(document.data())")
                        let message: ChatMessage = ChatMessage(
                            id: document.documentID,
                            messageType: document["type"] as! Int,
                            message: document["message"] as? String,
                            dateTime: document["timestamp"] as? String)
                        
                        try! realm.write{
                            realm.add(message)
                        }
                    }
                }
            }
        } catch let realmError as NSError{
            print("error - \(realmError.localizedDescription)")
        }
    }
}