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
                    
                    HStack {
                        Image(systemName: "hourglass.bottomhalf.filled").frame(width: 24, height: 24)
                        Text(selectedTask.name!)
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 8){
                        Label {
                            Text(selectedTask.startDate!)
                                .font(.subheadline)
                        } icon: {
                            Image(systemName: "calendar.badge.clock")
                        }
                        .padding()
                        
                    }
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                
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
            }
            .toast(isPresenting: $showToast) {
                AlertToast(type: .regular, title: toastMessage)
            }
        }.navigationTitle("Task Detials")
    }
}

struct EditTaskButtonContent : View {
    var body: some View {
        return Text("Modify")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 160, height: 60)
            .background(primaryBlack)
            .cornerRadius(15.0)
    }
}

struct CancelTaskButtonContent : View {
    var body: some View {
        return Text("Cancel")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 160, height: 60)
            .background(primaryBlack)
            .cornerRadius(15.0)
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(selectedTask: Ticket(id: "123456", name: "Task Name"))
    }
}
