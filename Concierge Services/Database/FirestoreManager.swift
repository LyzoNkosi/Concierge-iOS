import FirebaseFirestore
import FirebaseAuth
import FirebaseCore
import RealmSwift

class FirestoreManager: ObservableObject{
    
    @Published var someStr: String = ""
    
    func fetchUserDetails(userID: String, userDetailsLoaded: @escaping (Bool) -> ()) {
        let database = Firestore.firestore()
        
        let userRef = database.collection("users").document(userID)
        
        userRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                userDetailsLoaded(false)
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    UserDefaultsUtils.shared.setUserFirstName(value: data["first_name"] as? String ?? "")
                    UserDefaultsUtils.shared.setUserLastName(value: data["last_name"] as? String ?? "")
                    UserDefaultsUtils.shared.setUserRole(value: data["role"] as? Int ?? 1)
                    
                    userDetailsLoaded(true)
                }
            }
            
        }
    }
    
    func createAuthUser(email: String, password: String, firstName: String, lastName: String, newAuthUserCreated: @escaping (Bool) -> ()) {
        Auth.auth().createUser(withEmail: email.lowercased(), password: password, completion: { (user, error) in
            //Check that user isn't NIL
            if user != nil {
                //User is found
                self.addNewUser(userId: user?.user.uid ?? "", firstName: firstName, lastName: lastName) { userAdded in
                    if(userAdded) {
                        newAuthUserCreated(true)
                    } else {
                        newAuthUserCreated(false)
                    }
                }
            }
            else {
                newAuthUserCreated(false)
            }
        })
    }
    
    func changePassword(email : String, password : String, newPassword : String, passwordChanged : @escaping(Bool) ->())  {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if (error != nil) {
                print(error?.localizedDescription as Any)
                passwordChanged(false)
                return
            }
            
            if(authResult?.user == nil) {
                passwordChanged(false)
                return
            }
            
            let authUser = authResult?.user
            
            // User successfully reauthenticated, change the password
            authUser?.updatePassword(to: newPassword) { (error) in
                if let error = error {
                    // Failed to update the password
                    print("Failed to update the password: \(error)")
                    passwordChanged(false)
                    return
                }
                
                // Password successfully updated
                passwordChanged(true)
                
            }
        }
        
    }
    
    
    
    func resetPassword(newPass: String, passwordChanged: @escaping (Bool) -> ()){
        
    }
    
    private func addNewUser(userId: String, firstName: String, lastName: String, createdNewUser: @escaping (Bool) -> ()) {
        let database = Firestore.firestore()
        
        let data: [String: Any] = ["first_name" : firstName,
                                   "last_name" : lastName,
                                   "role" : 1]
        
        let ref = database.collection("users").document(userId)
        ref.setData(data) { error in
            if let error = error {
                print("Error writing document: \(error)")
                createdNewUser(false)
            } else {
                print("Document successfully written!")
                
                self.assignUserToAgent(agentId: UserDefaultsUtils.shared.getUserId(), userId: userId) { userAssigned in
                    if(userAssigned) {
                        createdNewUser(true)
                    } else {
                        createdNewUser(false)
                    }
                }
            }
        }
    }
    
    func assignUserToAgent(agentId: String, userId: String, userAssigned: @escaping (Bool) -> ()) {
        let database = Firestore.firestore()
        let ref = database.collection("agent_clients").document(agentId).collection("clients").document(userId)
        
        print("Agent id: \(agentId)")
        print("User id: \(userId)")
        
        ref.setData([String: String]()) { error in
            if let error = error {
                print("Error writing document: \(error)")
                userAssigned(false)
            } else {
                print("Document successfully written!")
                self.getAgentClients() { clientsSynced in
                    if(clientsSynced) {
                        userAssigned(true)
                    } else {
                        print("Error assigning client")
                        
                        userAssigned(false)
                    }
                }
            }
        }
    }
    
    func getGeneralTickets(loadedGeneralTickets: @escaping (Bool) -> ()) {
        let database = Firestore.firestore()
        
        do {
            let realm = try Realm()
            let generalTicketsToDelete = realm.objects(Ticket.self)
            let flightTicketsToDelete = realm.objects(FlightTicket.self)
            
            try! realm.write{
                realm.delete(generalTicketsToDelete)
                realm.delete(flightTicketsToDelete)
            }
            
            let ticketsRef = database.collection("tickets").document(UserDefaultsUtils.shared.getUserId()).collection("tickets")
            
            // Get General Tickets
            ticketsRef.whereField("ticket_type", isEqualTo: TicketType.GENERAL.rawValue as Int).getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                    loadedGeneralTickets(false)
                } else {
                    for ticketDocument in querySnapshot!.documents {
                        // General ticket
                        let ticket = Ticket(
                            id: ticketDocument.documentID,
                            name: ticketDocument["ticket_name"] as? String ?? "",
                            startDate: ticketDocument["start_date"] as? String ?? "",
                            status: ticketDocument["ticket_status"] as! Int,
                            ticketType: ticketDocument["ticket_type"] as! Int)
                        
                        try! realm.write {
                            realm.add(ticket)
                        }
                    }
                    loadedGeneralTickets(true)
                }
            }
        } catch let realmError as NSError{
            print("error - \(realmError.localizedDescription)")
        }
    }
    
    func getFlightTickets(loadedFlightTickets: @escaping (Bool) -> ()) {
        let database = Firestore.firestore()
        
        do {
            let realm = try Realm()
            let generalTicketsToDelete = realm.objects(Ticket.self)
            let flightTicketsToDelete = realm.objects(FlightTicket.self)
            
            try! realm.write{
                realm.delete(generalTicketsToDelete)
                realm.delete(flightTicketsToDelete)
            }
            
            let ticketsRef = database.collection("tickets").document(UserDefaultsUtils.shared.getUserId()).collection("tickets")
            
            // Get Flight Tickets
            ticketsRef.whereField("ticket_type", isEqualTo: TicketType.FLIGHT.rawValue as Int).getDocuments() { (querySnapshot, error) in
                for flightDocument in querySnapshot!.documents {
                    if let error = error {
                        print("Error getting documents: \(error)")
                        loadedFlightTickets(false)
                    } else {
                        let flightTicket = FlightTicket(id: flightDocument.documentID,
                                                        name: flightDocument["ticket_name"] as? String ?? "",
                                                        startDate: flightDocument["depart_date"] as? String ?? "",
                                                        status: flightDocument["ticket_status"] as! Int,
                                                        bookReturn: flightDocument["book_return"] as! Int,
                                                        departureAirport: flightDocument["depart_airport"] as? String ?? "",
                                                        destination: flightDocument["destination"] as? String ?? "",
                                                        destinationAirport: flightDocument["destination_airport"] as? String ?? "",
                                                        flightNumber: flightDocument["flight_number"] as? String ?? "",
                                                        seatNumber: flightDocument["seat_number"] as? String ?? "",
                                                        returnAirport: flightDocument["return_airport"] as? String ?? "",
                                                        returnDate: flightDocument["return_date"] as? String ?? "",
                                                        returnFlightNumber: flightDocument["return_flight_number"] as? String ?? "",
                                                        returnSeatNumber: flightDocument["return_seat_number"] as? String ?? "",
                                                        ticketType: flightDocument["ticket_type"] as! Int)
                        
                        try! realm.write {
                            realm.add(flightTicket)
                        }
                    }
                }
                loadedFlightTickets(true)
            }
        } catch let realmError as NSError{
            print("error - \(realmError.localizedDescription)")
        }
    }
    
    func getClientTickets(clientId: String, loadedAllTickets:@escaping ([Ticket]) -> ()) {
        var ticketsToReturn: [Ticket] = []
        
        self.getGeneralClientTickets(clientId: clientId) { loadedTickets in
            ticketsToReturn.append(contentsOf: loadedTickets)
            
            self.getFlightClientTickets(clientId: clientId) { loadedTickets in
                ticketsToReturn.append(contentsOf: loadedTickets)
                
                loadedAllTickets(ticketsToReturn)
            }
        }
    }
    
    func getFlightClientTickets(clientId: String, loadedClientTickets: @escaping ([Ticket]) -> ()) {
        let database = Firestore.firestore()
        
        let ticketsRef = database.collection("tickets").document(clientId).collection("tickets")
        
        var ticketsToReturn: [Ticket] = []
        
        // Get Flight Tickets
        ticketsRef.whereField("ticket_type", isEqualTo: TicketType.FLIGHT.rawValue as Int).getDocuments() { (querySnapshot, error) in
            for flightDocument in querySnapshot!.documents {
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    let flightTicket = FlightTicket(id: flightDocument.documentID,
                                                    name: flightDocument["ticket_name"] as? String ?? "",
                                                    startDate: flightDocument["depart_date"] as? String ?? "",
                                                    status: flightDocument["ticket_status"] as! Int,
                                                    bookReturn: flightDocument["book_return"] as! Int,
                                                    departureAirport: flightDocument["depart_airport"] as? String ?? "",
                                                    destination: flightDocument["destination"] as? String ?? "",
                                                    destinationAirport: flightDocument["destination_airport"] as? String ?? "",
                                                    flightNumber: flightDocument["flight_number"] as? String ?? "",
                                                    seatNumber: flightDocument["seat_number"] as? String ?? "",
                                                    returnAirport: flightDocument["return_airport"] as? String ?? "",
                                                    returnDate: flightDocument["return_date"] as? String ?? "",
                                                    returnFlightNumber: flightDocument["return_flight_number"] as? String ?? "",
                                                    returnSeatNumber: flightDocument["return_seat_number"] as? String ?? "",
                                                    ticketType: flightDocument["ticket_type"] as! Int)
                    
                    ticketsToReturn.append(flightTicket)
                }
            }
            loadedClientTickets(ticketsToReturn)
        }
    }
    
    func getGeneralClientTickets(clientId: String, loadedClientTickets: @escaping ([Ticket]) -> ()) {
        let database = Firestore.firestore()
        
        let ticketsRef = database.collection("tickets").document(clientId).collection("tickets")
        
        var ticketsToReturn: [Ticket] = []
        
        // Get General Tickets
        ticketsRef.whereField("ticket_type", isEqualTo: TicketType.GENERAL.rawValue as Int).getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for ticketDocument in querySnapshot!.documents {
                    // General ticket
                    let ticket = Ticket(
                        id: ticketDocument.documentID,
                        name: ticketDocument["ticket_name"] as? String ?? "",
                        startDate: ticketDocument["start_date"] as? String ?? "",
                        status: ticketDocument["ticket_status"] as! Int,
                        ticketType: ticketDocument["ticket_type"] as! Int)
                    
                    ticketsToReturn.append(ticket)
                }
                loadedClientTickets(ticketsToReturn)
            }
        }
    }
    
    func getAgentClientTickets(finished: @escaping (String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            print("Getting your client tickets")
            finished("Ticket values go here")
        }
    }
    
    func createTicket(clientId: String, ticket: Ticket, ticketCreated: @escaping (Bool) -> ()) {
        let database = Firestore.firestore()
        
        let data: [String: Any] = ["ticket_name" : ticket.name!,
                                   "start_date" : ticket.startDate!,
                                   "ticket_type" : ticket.ticketType,
                                   "ticket_status" : TicketStatus.STATUS_NOT_STARTED.rawValue]
        
        let ref = database.collection("tickets").document(clientId).collection("tickets").document()
        
        ref.setData(data) { error in
            if let error = error {
                print("Error writing document: \(error)")
                ticketCreated(false)
            } else {
                print("Document successfully written!")
                ticketCreated(true)
            }
        }
    }
    
    func createFlightTicket(clientId: String, ticket: FlightTicket, ticketCreated: @escaping (Bool) -> ()) {
        let database = Firestore.firestore()
        
        let data: [String: Any] = ["ticket_name" : ticket.name ?? "",
                                   "depart_date" : ticket.startDate ?? "",
                                   "return_date" : ticket.returnDate ?? "",
                                   "book_return" : ticket.bookReturn,
                                   "depart_airport" : ticket.departureAirport ?? "",
                                   "return_airport" : ticket.returnAirport ?? "",
                                   "ticket_type" : ticket.ticketType,
                                   "destination" : ticket.destination ?? "",
                                   "destination_airport" : ticket.departureAirport ?? "",
                                   "flight_number" : ticket.flightNumber ?? "",
                                   "seat_number" : ticket.seatNumber ?? "",
                                   "return_flight_number" : ticket.returnFlightNumber ?? "",
                                   "return_seat_number" : ticket.returnSeatNumber ?? "",
                                   "ticket_status" : TicketStatus.STATUS_NOT_STARTED.rawValue]
        
        let ref = database.collection("tickets").document(clientId).collection("tickets").document()
        
        ref.setData(data) { error in
            if let error = error {
                print("Error writing document: \(error)")
                ticketCreated(false)
            } else {
                print("Document successfully written!")
                ticketCreated(true)
            }
        }
    }
    
    func getAgentClients(clientsSynced: @escaping (Bool) -> ()) {
        let database = Firestore.firestore()
        
        do {
            let realm = try Realm()
            let clientsToDelete = realm.objects(Client.self)
            
            try! realm.write {
                realm.delete(clientsToDelete)
            }
            
            database.collection("agent_clients").document(UserDefaultsUtils.shared.getUserId()).collection("clients").getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in querySnapshot!.documents {
                        let userRef = database.collection("users").document(document.documentID)
                        
                        userRef.getDocument { (userDocument, userError) in
                            guard userError == nil else {
                                print("error", userError ?? "")
                                clientsSynced(false)
                                return
                            }
                            
                            if let userDoc = userDocument, userDoc.exists {
                                let userData = userDoc.data()
                                if let userData = userData {
                                    let client = Client(
                                        id: document.documentID,
                                        firstName: userData["first_name"] as? String ?? "",
                                        lastName: userData["last_name"] as? String ?? "")
                                    
                                    try! realm.write {
                                        realm.add(client)
                                    }
                                }
                            }
                        }
                    }
                    clientsSynced(true)
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
    
    func sendClientChatMessage(clientId: String, messageText: String, messageSent: @escaping (ChatMessage?) -> ()) {
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
        
        let ref = database.collection("chats").document(UserDefaultsUtils.shared.getUserId()).collection("messages").document()
        
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
    
    private func updateLocalMessageStore(message: ChatMessage) {
        do {
            let realm = try Realm()
            
            try! realm.write {
                realm.add(message)
            }
            
        } catch let realmError as NSError {
            print("error - \(realmError.localizedDescription)")
        }
    }
    
    func getMyChatMessages(loadedMessages: @escaping (Bool) -> ()) {
        let database = Firestore.firestore()
        
        do{
            let realm = try Realm()
            let messagesToDelete = realm.objects(ChatMessage.self)
            
            try! realm.write{
                realm.delete(messagesToDelete)
            }
            
            database.collection("chats").document(UserDefaultsUtils.shared.getUserId()).collection("messages").getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                    loadedMessages(false)
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
                    loadedMessages(true)
                }
            }
        } catch let realmError as NSError{
            print("error - \(realmError.localizedDescription)")
        }
    }
}
