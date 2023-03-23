import Foundation
import RealmSwift

class TimelineViewModel: ObservableObject{
    
    @Published var tickets: [Ticket] = []
    //@Published var generalTickets: [Ticket] = []
    //@Published var flightTickets: [FlightTicket] = []
    
    func getTickets() {
        var realmTickets: [Ticket] = []
        
        let realm = try! Realm()
        
        for generalTicket in realm.objects(Ticket.self) {
            realmTickets.append(generalTicket)
        }
        
        for flightTicket in realm.objects(FlightTicket.self) {
            realmTickets.append(flightTicket)
        }
        
        self.tickets = realmTickets
    }
    
    /*func getGeneralTickets() {
        var realmGeneralTickets: [Ticket] = []
        
        let realm = try! Realm()
        
        for realmTicket in realm.objects(Ticket.self) {
            realmGeneralTickets.append(realmTicket)
        }
        self.generalTickets = realmGeneralTickets
    }
    
    func getFlightTickets() {
        var realmFlightTickets: [FlightTicket] = []
        
        let realm = try! Realm()
        
        for realmTicket in realm.objects(FlightTicket.self) {
            realmFlightTickets.append(realmTicket)
        }
        self.flightTickets = realmFlightTickets
    }*/
}
