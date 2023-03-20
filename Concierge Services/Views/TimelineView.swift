import SwiftUI

struct TimelineView: View {

    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @StateObject var ticketsViewModel: TimelineViewModel = TimelineViewModel()
    
    var body: some View {
        
        VStack {
            List(ticketsViewModel.tickets) { task in
                NavigationLink(
                    destination: TaskDetailView(selectedTask: task)
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
                                Text(task.startDate!)
                                    .font(Font.custom("Poppins-Regular", size: 14))
                                    .foregroundColor(Color.ColorPrimary)
                            } icon: {
                                Image(systemName: "calendar.badge.clock")
                                    .foregroundColor(Color.ColorPrimary)
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
                }
            }
        }
        .onAppear {
            ticketsViewModel.getTickets(firestoreManager: firestoreManager)
        }
    }
}


struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}

struct dummyView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct dummyView_Previews: PreviewProvider {
    static var previews: some View {
        dummyView()
    }
}
