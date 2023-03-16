struct Ticket {
    let id: String
    let name: String
    let status: String
}

enum TicketStatus: Int{
    case STATUS_NOT_STARTED = 0
    case STATUS_IN_PROGRESS = 1
    case STATUS_COMPLETE = 2
    case STATUS_RECURRING = 3
}
