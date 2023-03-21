import SwiftUI
import ActivityIndicatorView
import AlertToast
import Combine

struct CreateFlightTaskView: View {
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
            Color.BackgroundColorList.edgesIgnoringSafeArea(.all)
            
            ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .default())
                .frame(width: 64, height: 64)
                .foregroundColor(Color.ColorPrimary)
            
            CreateTaskLabelText()
            
            ScrollView {
                
                TaskNameInput()
                
                DatePicker("Start Date", selection: $date, in: dateClosedRange)
                    .padding()
            }
            
        }
        .safeAreaInset(edge: .bottom) {
            
            CreateTaskButtonContent()
                .onTapGesture {
                    if(!showLoadingIndicator) {
                        self.showLoadingIndicator = true
                        
                        let formatter = DateFormatter()
                        formatter.timeZone = TimeZone.current
                        formatter.dateFormat = "yyyy-MM-dd HH:mm"
                        let dateString = formatter.string(from: self.date)
                        
                        let ticket = Ticket(id: "", name: ticketName, startDate: dateString, status: TicketStatus.STATUS_NOT_STARTED.rawValue)
                        
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
                        
                        if(self.ticketName.count < 5) {
                            self.toastMessage = "Task name is too short"
                            self.showToast = true
                            return
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
        .padding(12)
        .navigationBarTitle("Create Flight Task")
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

struct CreateFlightTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateFlightTaskView(selectedClient: Client(id: "", firstName: "", lastName: ""))
    }
}
