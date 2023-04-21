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
                        .frame(width: 1, height: 10, alignment: .center)
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color.ColorPrimary)
                    Rectangle()
                        .frame(width: 1, height: 10, alignment: .center)
                    Circle()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.ColorPrimary)
                        .overlay(
                            Image("hourglass")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 14, height: 14)
                            
                        )
                    Rectangle()
                        .frame(width: 1, height: 20, alignment: .center)
                        .foregroundColor(Color.ColorPrimary)
                }
                .frame(width: 24, height: .infinity, alignment: .center)
                .foregroundColor(Color.ColorPrimary)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    
                    HStack {
                        Image("calendar")
                            .resizable()
                            .frame(width: 12, height: 12)
                        
                        Text(ticket.startDate ?? "No start date")
                            .font(Font.custom("Poppins-Regular", size: Constants.TASK_DATE_FONT_SIZE))
                            .foregroundColor(Color.ColorPrimary)
                        
                        
                    }
                    
                    Text(ticket.name ?? "No task name")
                        .font(Font.custom("Poppins-Medium", size: Constants.TASK_NAME_FONT_SIZE))
                        .foregroundColor(Color.ColorPrimary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    
                })
                .padding(4)
                
            case TicketType.FLIGHT.rawValue:
                
                let flightTicket = ticket as? FlightTicket
                
                VStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .frame(width: 1, height: 10, alignment: .center)
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color.ColorPrimary)
                    Rectangle()
                        .frame(width: 1, height: 10, alignment: .center)
                    Circle()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.ColorPrimary)
                        .overlay(
                            Image(systemName: "airplane")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16, weight: .light , design: .rounded))
                                .frame(width: 24, height: 24)
                        )
                    Rectangle()
                        .frame(width: 1, height: 20, alignment: .center)
                        .foregroundColor(Color.ColorPrimary)
                }
                .frame(width: 24, height: .infinity, alignment: .center)
                .foregroundColor(Color.ColorPrimary)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    HStack {
                        
                        Image("calendar")
                            .resizable()
                            .frame(width: 12, height: 12)
                        
                        Text(flightTicket?.startDate ?? "No departure date")
                            .font(Font.custom("Poppins-Regular", size: Constants.TASK_DATE_FONT_SIZE))
                            .foregroundColor(Color.ColorPrimary)
                    }
                    
                    HStack {
                        
                        Text(flightTicket?.name ?? "No task name")
                            .font(Font.custom("Poppins-Medium", size: Constants.TASK_NAME_FONT_SIZE))
                            .foregroundColor(Color.ColorPrimary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                        
                        HStack {
                            HStack {
                                Image(systemName: "airplane")
                                    .foregroundColor(Color.Accent)
                                
                                Text(flightTicket?.flightNumber ?? "None")
                                    .font(Font.custom("Poppins-Light", size: Constants.TASK_NAME_FONT_SIZE))
                                    .foregroundColor(Color.ColorPrimary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                            }
                            
                            HStack {
                                Image("flight_seat")
                                    .resizable()
                                    .frame(width: 14, height: 18)
                                
                                Text(flightTicket?.seatNumber ?? "None")
                                    .font(Font.custom("Poppins-Light", size: Constants.TASK_NAME_FONT_SIZE))
                                    .foregroundColor(Color.ColorPrimary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                
                            }
                        }
                        
                    }
                    
                })
                .padding(4)
                
            default:
                EmptyView()
            }
            
        }
        //.padding(4)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

struct TaskHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        
        /*TaskHeaderView(
         ticket: Ticket(
         id: "123456",
         name: "Task Name",
         startDate: "2023-03-28 11:09",
         status: TicketStatus.STATUS_IN_PROGRESS.rawValue,
         ticketType: TicketType.GENERAL.rawValue
         )
         )*/
        
        TaskHeaderView(
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
        )
        
    }
}
