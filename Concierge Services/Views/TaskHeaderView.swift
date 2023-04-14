//
//  TaskHeaderView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/14.
//

import SwiftUI

struct TaskHeaderView : View  {
    
    var ticket: Ticket
    
    var body: some View {
        return HStack(alignment: .top, spacing: 0) {
            
            switch(ticket.ticketType) {
                
            case TicketType.GENERAL.rawValue:
                VStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .frame(width: 1, height: 20, alignment: .center)
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.Accent)
                        .overlay(
                            Image("hourglass")
                                .resizable()
                                .frame(width: 16, height: 16)
                        )
                    Rectangle()
                        .frame(width: 1, height: 20, alignment: .center)
                        .foregroundColor(Color.ColorPrimary)
                }
                .frame(width: 32, height: .infinity, alignment: .center)
                .foregroundColor(Color.ColorPrimary)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Label {
                        Text(ticket.startDate ?? "No start date")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image("calendar")
                            .resizable()
                            .frame(width: 18, height: 18)
                    }
                    
                    Text(ticket.name ?? "No task name")
                        .font(Font.custom("Poppins-Medium", size: 18))
                        .foregroundColor(Color.ColorPrimary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    
                })
                
            case TicketType.FLIGHT.rawValue:
                
                let flightTicket = ticket as? FlightTicket
                
                VStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .frame(width: 1, height: 20, alignment: .center)
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.Accent)
                        .overlay(
                            Image(systemName: "airplane")
                                .foregroundColor(Color.ColorPrimary)
                                .font(.system(size: 16, weight: .light , design: .rounded))
                                .frame(width: 30, height: 30)
                        )
                    Rectangle()
                        .frame(width: 1, height: 20, alignment: .center)
                        .foregroundColor(Color.ColorPrimary)
                }
                .frame(width: 32, height: .infinity, alignment: .center)
                .foregroundColor(Color.ColorPrimary)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Label {
                        Text(flightTicket?.startDate ?? "No departure date")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image("calendar")
                            .resizable()
                            .frame(width: 18, height: 18)
                    }
                    
                    Text(flightTicket?.name ?? "No task name")
                        .font(Font.custom("Poppins-Medium", size: 18))
                        .foregroundColor(Color.ColorPrimary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    
                })
                
            default:
                EmptyView()
            }
            
        }.padding(4)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

struct TaskHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        
        TaskHeaderView(
            ticket: Ticket(
                id: "123456",
                name: "Task Name",
                startDate: "2023-03-28 11:09",
                status: TicketStatus.STATUS_IN_PROGRESS.rawValue,
                ticketType: TicketType.GENERAL.rawValue
            )
        )
        
        /*TaskHeaderView(
         ticket: FlightTicket(
         id: "123456",
         name: "Task Name",
         startDate: "2023-03-28 11:09",
         status: TicketStatus.STATUS_IN_PROGRESS.rawValue,
         bookReturn: 1,
         departureAirport: "Rand Airport",
         destination: "Cape Town",
         destinationAirport: "CPT International",
         flightNumber: "NS 544123",
         seatNumber: "C34",
         returnAirport: "CPT International",
         returnDate: "2023-03-28 11:09",
         returnFlightNumber: "GL 1224",
         returnSeatNumber: "A12",
         ticketType: TicketType.FLIGHT.rawValue
         )
         )*/
        
    }
}
