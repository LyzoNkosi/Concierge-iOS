import Foundation

class ClientTicketsViewModel: ObservableObject{
    
    @Published var tickets: [Ticket] = []
    //@Published var ticketValue: String = "No Ticket Value"
    
    func getClientTickets(firestoreManager: FirestoreManager, clientId: String/*, loadedTickets:@escaping ([Ticket])->()*/) {
        firestoreManager.getClientTickets(clientId: clientId) { ticketsList in
            //loadedTickets(ticketsList)
            self.tickets = ticketsList
        }
    }
    
    /*func getClientTickets(firestoreManager: FirestoreManager, clientId: String, loadedTickets:@escaping ([Ticket])->()) {
        firestoreManager.getClientTickets(clientId: clientId) { ticketsList in
            loadedTickets(ticketsList)
            self.tickets = ticketsList
        }
    }*/
    
    /*func getClientTickets(firestoreManager: FirestoreManager, clientId: String, finished: @escaping (String) -> ()){
     firestoreManager.getAgentClientTickets { ticketValueReceived in
     //print(ticketValueReceived)
     finished(ticketValueReceived)
     }
     }*/
}
