import SwiftUI

struct ClientTicketsView: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @StateObject var clientTicketsViewModel: ClientTicketsViewModel = ClientTicketsViewModel()
    
    @State var selectedClient: Client
    
    var body: some View {
        //let tasks: [String] = ["Sky diving trip", "Laundry run", "Flight to Mali", "Golf", "Birthday Present Delivery"]
        NavigationView{
            VStack{
                
                List(clientTicketsViewModel.tickets) { task in
                   NavigationLink(
                       destination: TaskDetailView()
                   ) {
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
                                       Image(systemName: "car")
                                           .foregroundColor(.white)
                                           .font(.system(size: 16, weight: .light , design: .rounded))
                                           .frame(width: 30, height: 30)
                                   )
                               Rectangle()
                                   .frame(width: 1, height: 40, alignment: .center)
                                   .foregroundColor(primaryBlack)
                           }
                           .frame(width: 32, height: 80, alignment: .center)
                           .foregroundColor(primaryBlack)
                           
                           
                           VStack(alignment: .leading, spacing: 8, content: {
                               Text(task.name ?? "")
                                   .font(.subheadline)
                                   .multilineTextAlignment(.leading)
                                   .lineLimit(1)
                               Label {
                                   Text("14:04")
                                       .font(.caption2)
                               } icon: {
                                   Image(systemName: "calendar.badge.clock")
                               }
                               
                               HStack {
                                   // Add attachments here
                                   
                               }
                               
                           })
                       }.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                   }
               }
                
                /*clientTicketsViewModel.getClientTickets(firestoreManager: firestoreManager, clientId: selectedClient.id!) { loadedTickets in
                 
                 TasksListView(tasks: loadedTickets)
                 
                 CreateTaskButtonContent()
                 }*/
                /*.onAppear {
                 /*clientTicketsViewModel.getClientTickets(firestoreManager: firestoreManager, clientId: selectedClient.id! ){ stringToProcess in
                  print(stringToProcess)
                  }*/
                 
                 }*/
            }
            .onAppear{
                clientTicketsViewModel.getClientTickets(firestoreManager: firestoreManager, clientId: selectedClient.id!)
            }
        }
    }
}

struct ClientTicketsView_Previews: PreviewProvider {
    static var previews: some View {
        ClientTicketsView(selectedClient: Client(id: "123456", firstName: "John", lastName: "Doe"))
    }
}

struct CreateTaskButtonContent : View {
    var body: some View {
        return Text("Create Task")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(primaryBlack)
            .cornerRadius(15.0)
    }
}
