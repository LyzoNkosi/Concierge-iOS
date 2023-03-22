import Foundation
import RealmSwift

class FlightTicket : Ticket {
    @Persisted var bookReturn: Int = 0
    @Persisted var departureAirport: String? = ""
    @Persisted var returnAirport: String? = ""
    @Persisted var returnDate: String? = ""
    
    override init() {
        super.init()
    }
    
    init(id: String? = nil,
         name: String? = nil,
         startDate: String? = nil,
         status: Int = TicketStatus.STATUS_NOT_STARTED.rawValue,
         bookReturn: Int,
         departureAirport: String? = nil,
         returnAirport: String? = nil,
         returnDate: String? = nil,
         ticketType: Int = 0) {
        super.init(id: id, name: name, startDate: startDate, status: status, ticketType: ticketType)
        self.bookReturn = bookReturn
        self.departureAirport = departureAirport
        self.returnAirport = returnAirport
        self.returnDate = returnDate
    }
}
