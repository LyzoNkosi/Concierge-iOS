import SwiftUI

struct ClientTicketsView: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @StateObject var clientTicketsViewModel: ClientTicketsViewModel = ClientTicketsViewModel()
    
    @State var selectedClient: Client
    
    var body: some View {
        VStack {
            
            List(clientTicketsViewModel.tickets) { task in
                NavigationLink(
                    destination: TaskDetailView(selectedTask: task, userId: selectedClient.id!)
                ) {
                    switch(task.ticketType) {
                    case TicketType.FLIGHT.rawValue:
                        
                        let flightTicket = task as? FlightTicket
                        
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
                                    .foregroundColor(Color.Accent)
                                    .overlay(
                                        Image(systemName: "airplane")
                                            .foregroundColor(Color.ColorPrimary)
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
                                    Image("calendar")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                                
                                Text(flightTicket?.name ?? "")
                                    .font(Font.custom("Poppins-Medium", size: 16))
                                    .foregroundColor(Color.ColorPrimary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                
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
                                    .foregroundColor(Color.Accent)
                                    .overlay(
                                        Image("hourglass")
                                            .resizable()
                                            .frame(width: 18, height: 18)
                                    )
                                Rectangle()
                                    .frame(width: 1, height: 40, alignment: .center)
                                    .foregroundColor(Color.ColorPrimary)
                            }
                            .frame(width: 32, height: 80, alignment: .center)
                            .foregroundColor(Color.ColorPrimary)
                            
                            VStack(alignment: .leading, spacing: 8, content: {
                                Label {
                                    Text(task.startDate!)
                                        .font(Font.custom("Poppins-Regular", size: 14))
                                        .foregroundColor(Color.ColorPrimary)
                                } icon: {
                                    Image("calendar")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                                
                                Text(task.name ?? "")
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
            }
        }
        .onAppear {
            clientTicketsViewModel.getClientTickets(firestoreManager: firestoreManager, clientId: selectedClient.id!)
        }
        .safeAreaInset(edge: .bottom) {
            
            NavigationLink(destination: SelectTaskTypeView(selectedClient: selectedClient).environmentObject(firestoreManager)) {
                CreateTaskButtonContent()
            }
            
        }
    }
}

struct ClientTicketsView_Previews: PreviewProvider {
    static var previews: some View {
        ClientTicketsView(selectedClient: Client(id: "123456", firstName: "John", lastName: "Doe"))
            .environmentObject(FirestoreManager())
    }
}

struct CreateTaskButtonContent : View {
    var body: some View {
        return Text("Create Task")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(LinearGradient(gradient: Gradient(colors: [Color.ColorPrimary, Color.ColorSecondary]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(15.0)
    }
}
