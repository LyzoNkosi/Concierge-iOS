import SwiftUI
import AlertToast

struct TaskDetailView: View {
    
    var selectedTask: Ticket
    
    @State private var showToast = false
    @State private var toastMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading, spacing: 8) {
                    
                    switch(selectedTask.ticketType) {
                    case TicketType.FLIGHT.rawValue:
                        
                        let flightTicket = selectedTask as? FlightTicket
                        
                        HStack(alignment: .top, spacing: 0) {
                            VStack(alignment: .center, spacing: 0) {
                                Rectangle()
                                    .frame(width: 1, height: 30, alignment: .center)
                                Circle()
                                    .frame(width: 10, height: 10)
                                Rectangle()
                                    .frame(width: 1, height: 20, alignment: .center)
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Image(systemName: "airplane")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16, weight: .light , design: .rounded))
                                            .frame(width: 30, height: 30)
                                    )
                                Rectangle()
                                    .frame(width: 1, height: 40, alignment: .center)
                                    .foregroundColor(Color.ColorPrimary)
                            }
                            .frame(width: 32, height: 80, alignment: .center)
                            .foregroundColor(Color.ColorPrimary)
                            
                            VStack(alignment: .leading, spacing: 8, content: {
                                Label {
                                    Text(flightTicket?.startDate ?? "No departure date")
                                        .font(Font.custom("Poppins-Regular", size: 14))
                                        .foregroundColor(Color.ColorPrimary)
                                } icon: {
                                    Image(systemName: "calendar.badge.clock")
                                        .foregroundColor(Color.ColorPrimary)
                                }
                                
                                Text(flightTicket?.name ?? "")
                                    .font(Font.custom("Poppins-Medium", size: 20))
                                    .foregroundColor(Color.ColorPrimary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                
                                Divider()
                                    .padding(8)
                                
                                Label {
                                    Text("Departure Airport: " + (flightTicket?.departureAirport ?? "No departure airport"))
                                        .font(Font.custom("Poppins-Regular", size: 14))
                                        .foregroundColor(Color.ColorPrimary)
                                } icon: {
                                    Image(systemName: "figure.walk.departure")
                                        .foregroundColor(Color.ColorPrimary)
                                }
                                
                                Divider()
                                    .padding(8)
                                
                                if(flightTicket?.bookReturn != 0) {
                                    
                                    Label {
                                        Text("Return Airport: " + (flightTicket?.returnAirport ?? "No return airport"))
                                            .font(Font.custom("Poppins-Regular", size: 14))
                                            .foregroundColor(Color.ColorPrimary)
                                    } icon: {
                                        Image(systemName: "airplane.arrival")
                                            .foregroundColor(Color.ColorPrimary)
                                    }
                                    
                                    Divider()
                                        .padding(8)
                                    
                                    Label {
                                        Text("Return Date: " + (flightTicket?.returnDate ?? "No return date"))
                                            .font(Font.custom("Poppins-Regular", size: 14))
                                            .foregroundColor(Color.ColorPrimary)
                                    } icon: {
                                        Image(systemName: "calendar.badge.clock")
                                            .foregroundColor(Color.ColorPrimary)
                                    }
                                    
                                    Divider()
                                        .padding(8)
                                }
                                
                                
                            })
                        }.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                    case TicketType.GENERAL.rawValue:
                        
                        HStack(alignment: .top, spacing: 0) {
                            VStack(alignment: .center, spacing: 0){
                                Rectangle()
                                    .frame(width: 1, height: 30, alignment: .center)
                                Circle()
                                    .frame(width: 10, height: 10)
                                Rectangle()
                                    .frame(width: 1, height: 20, alignment: .center)
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Image(systemName: "hourglass.bottomhalf.filled")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16, weight: .light , design: .rounded))
                                            .frame(width: 30, height: 30)
                                    )
                                Rectangle()
                                    .frame(width: 1, height: 40, alignment: .center)
                                    .foregroundColor(Color.ColorPrimary)
                            }
                            .frame(width: 32, height: 80, alignment: .center)
                            .foregroundColor(Color.ColorPrimary)
                            
                            VStack(alignment: .leading, spacing: 8, content: {
                                Label {
                                    Text(selectedTask.startDate!)
                                        .font(Font.custom("Poppins-Regular", size: 14))
                                        .foregroundColor(Color.ColorPrimary)
                                } icon: {
                                    Image(systemName: "calendar.badge.clock")
                                        .foregroundColor(Color.ColorPrimary)
                                }
                                
                                Text(selectedTask.name ?? "")
                                    .font(Font.custom("Poppins-Medium", size: 16))
                                    .foregroundColor(Color.ColorPrimary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                
                                HStack {
                                    // Add attachments here
                                    
                                }
                                
                            })
                        }.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                    default:
                        EmptyView()
                    }
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                .padding()
            }
            .toast(isPresenting: $showToast) {
                AlertToast(type: .regular, title: toastMessage,
                           style: AlertToast.AlertStyle.style(backgroundColor: Color.ColorPrimary, titleColor: Color.TextColorPrimary, subTitleColor: Color.TextColorPrimary, titleFont: Font.custom("Poppins-Regular", size: 12), subTitleFont: Font.custom("Poppins-Light", size: 12)))
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack(alignment: .center, spacing: 8) {
                
                EditTaskButtonContent()
                    .onTapGesture {
                        self.toastMessage = "This feature is coming sooon"
                        self.showToast = true
                    }
                
                CancelTaskButtonContent()
                    .onTapGesture {
                        self.toastMessage = "This feature is coming sooon"
                        self.showToast = true
                    }
            }
            
        } .padding(12)
            .navigationTitle("Task Details")
            .font(Font.custom("Poppins-Regular", size: 20))
    }
}

struct EditTaskButtonContent : View {
    var body: some View {
        return Text("Modify")
            .font(Font.custom("Poppins-Medium", size: 18))
            .foregroundColor(Color.TextColorPrimary)
            .padding()
            .frame(width: 160, height: 60)
            .background(LinearGradient(gradient: Gradient(colors: [Color.ColorPrimary, Color.ColorSecondary]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(15.0)
    }
}

struct CancelTaskButtonContent : View {
    var body: some View {
        return Text("Cancel")
            .font(Font.custom("Poppins-Medium", size: 18))
            .foregroundColor(Color.TextColorPrimary)
            .padding()
            .frame(width: 160, height: 60)
            .background(LinearGradient(gradient: Gradient(colors: [Color.ColorPrimary, Color.ColorSecondary]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(15.0)
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(selectedTask: Ticket(id: "123456", name: "Task Name"))
    }
}
