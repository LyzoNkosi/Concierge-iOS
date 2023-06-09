import SwiftUI
import ActivityIndicatorView
import AlertToast
import Combine

struct CreateTaskView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @Environment(\.presentationMode) var createTaskPresentation
    
    @State private var showLoadingIndicator: Bool = false
    
    @State private var showToast = false
    @State private var toastMessage = ""
    
    @State var selectedClient: Client?
    
    @State var ticketName: String = ""
    
    @State private var date = Date()
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .day, value: -0, to: Date())!
        let max = Calendar.current.date(byAdding: .day, value: 365, to: Date())!
        return min...max
    }
    
    var body: some View {
        
        VStack {
            
            ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .default())
                .frame(width: 64, height: 64)
                .foregroundColor(Color.ColorPrimary)
            
            TaskNameInput()
            
            DatePicker("Start Date", selection: $date, in: dateClosedRange)
                .padding()
            
            Spacer()
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .safeAreaInset(edge: .bottom) {
            
            CreateTaskButtonContent()
                .onTapGesture {
                    if(!showLoadingIndicator) {
                        
                        if(self.ticketName.count < 5) {
                            self.toastMessage = "Task name is too short"
                            self.showToast = true
                            return
                        }
                        
                        self.showLoadingIndicator = true
                        
                        let formatter = DateFormatter()
                        formatter.timeZone = TimeZone.current
                        formatter.dateFormat = "yyyy-MM-dd HH:mm"
                        let dateString = formatter.string(from: self.date)
                        
                        let ticket = Ticket(
                            id: "",
                            name: ticketName,
                            startDate: dateString,
                            status: TicketStatus.STATUS_NOT_STARTED.rawValue,
                            ticketType: TicketType.GENERAL.rawValue
                        )
                        
                        firestoreManager.createTicket(clientId: selectedClient?.id ?? "", ticket: ticket) { ticketCreated in
                            if(ticketCreated) {
                                self.showLoadingIndicator = false
                                self.toastMessage = "Task created"
                                self.showToast = true
                                self.createTaskPresentation.wrappedValue.dismiss()
                            } else {
                                self.showLoadingIndicator = false
                                self.toastMessage = "Error creating task"
                                self.showToast = true
                            }
                        }
                        
                        
                    } else {
                        self.toastMessage = "Task creation in progress"
                        self.showToast = true
                    }
                }
        }
        .toast(isPresenting: $showToast) {
            AlertToast(type: .regular, title: toastMessage,
                       style: AlertToast.AlertStyle.style(backgroundColor: Color.ColorPrimary, titleColor: Color.TextColorPrimary, subTitleColor: Color.TextColorPrimary, titleFont: Font.custom("Poppins-Regular", size: 12), subTitleFont: Font.custom("Poppins-Light", size: 12)))
        }
        .padding()
        .navigationBarTitle("Create Task")
    }
    
    fileprivate func TaskNameInput() -> some View {
        TextField("Task Name", text: $ticketName)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disableAutocorrection(true)
            .padding(.bottom, 20)
    }
}

struct CreateTaskLabelText : View {
    var body: some View {
        return Text("Create Task")
            .font(Font.custom("Poppins-Regular", size: 20))
            .fontWeight(.semibold)
            .padding(.bottom, 20)
            .foregroundColor(Color.TextColorSecondary).font(Font.custom("Poppins-Regular", size: 15))
    }
}

struct CreateTaskViewView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView(selectedClient: Client(id: "", firstName: "", lastName: ""))
    }
}
