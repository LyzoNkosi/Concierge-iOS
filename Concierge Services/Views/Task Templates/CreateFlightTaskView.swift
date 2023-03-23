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
    @State var destination: String = ""
    @State var airport: String = ""
    @State var returnAirport: String = ""
    @State var bookReturn: Bool = false
    
    @State private var departureDate = Date()
    @State private var returnDate = Date()
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
            
            ScrollView {
                
                TaskNameInput()
                
                DatePicker("Departure Date", selection: $departureDate, in: dateClosedRange)
                    .padding()
                
                Toggle("Book Return", isOn: $bookReturn)
                    .padding(4)
                
                if(bookReturn) {
                    DatePicker("Return Date", selection: $returnDate, in: dateClosedRange)
                        .padding()
                }
                
                DestinationInput()
                
                AirportInput()
                
                if(bookReturn) {
                    ReturnAirportInput()
                }
                
            }
            
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
                        
                        if(self.destination.count < 3) {
                            self.toastMessage = "Destination is too short"
                            self.showToast = true
                            return
                        }
                        
                        if(self.airport.count < 3) {
                            self.toastMessage = "Departure airport name is too short"
                            self.showToast = true
                            return
                        }
                        
                        if(bookReturn) {
                            if (departureDate == returnDate) {
                                self.toastMessage = "Departure date is similar to return date"
                                self.showToast = true
                                return
                            }
                        }
                        
                        if(bookReturn) {
                            if(self.returnAirport.count < 3) {
                                self.toastMessage = "Return airport name is too short"
                                self.showToast = true
                                return
                            }
                        }
                        
                        self.showLoadingIndicator = true
                        
                        let formatter = DateFormatter()
                        formatter.timeZone = TimeZone.current
                        formatter.dateFormat = "yyyy-MM-dd HH:mm"
                        let departureDateString = formatter.string(from: self.departureDate)
                        let returnDateString = formatter.string(from: self.returnDate)
                        
                        var bookReturnInt = 0
                        if(bookReturn) {
                            bookReturnInt = 1
                        }
                        
                        let ticket = FlightTicket(id: "",
                                                 name: ticketName,
                                                 startDate: departureDateString,
                                                 status: TicketStatus.STATUS_NOT_STARTED.rawValue,
                                                 bookReturn: bookReturnInt,
                                                 departureAirport: airport,
                                                 returnAirport: returnAirport,
                                                 returnDate: returnDateString,
                                                 ticketType: TicketType.FLIGHT.rawValue)
                        
                        firestoreManager.createFlightTicket(clientId: selectedClient?.id ?? "", ticket: ticket) { ticketCreated in
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
    
    fileprivate func DestinationInput() -> some View {
        TextField("Destination", text: $destination)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disableAutocorrection(true)
            .padding(.bottom, 20)
    }
    
    fileprivate func AirportInput() -> some View {
        TextField("Departure Airport", text: $airport)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disableAutocorrection(true)
            .padding(.bottom, 20)
    }
    
    fileprivate func ReturnAirportInput() -> some View {
        TextField("Return Airport", text: $returnAirport)
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
