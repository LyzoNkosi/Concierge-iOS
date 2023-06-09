//
//  TaskContentView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/14.
//

import SwiftUI

struct TaskContentView: View {
    
    var selectedTask: Ticket
    var userId: String
    
    @State private var showToast = false
    @State private var toastMessage = ""
    
    @State private var taskFilesURLs: [URL] = []
    
    var body: some View {
        VStack (alignment: .leading) {
            
            switch(selectedTask.ticketType) {
                
            case TicketType.FLIGHT.rawValue:
                
                let flightTicket = selectedTask as? FlightTicket
                
                HStack {
                    Label {
                        Text("Destination: ")
                            .font(Font.custom("Poppins-Medium", size: Constants.TASK_HEADERS_FONT_SIZE))
                            .foregroundColor(Color.ColorPrimary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                    } icon: {
                        Image(systemName: "figure.walk.arrival")
                            .foregroundColor(Color.Accent)
                    }
                    
                    Text(flightTicket?.destination ?? "No arrival airport")
                        .font(Font.custom("Poppins-Regular", size: Constants.TASK_NAME_FONT_SIZE))
                        .foregroundColor(Color.ColorPrimary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                }
                .padding(4)
                
                HStack {
                    Label {
                        Text("Departure Airport: ")
                            .font(Font.custom("Poppins-Medium", size: Constants.TASK_HEADERS_FONT_SIZE))
                            .foregroundColor(Color.ColorPrimary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                    } icon: {
                        Image(systemName: "airplane.departure")
                            .foregroundColor(Color.Accent)
                    }
                    
                    Text(flightTicket?.departureAirport ?? "No departure airport")
                        .font(Font.custom("Poppins-Regular", size: Constants.TASK_NAME_FONT_SIZE))
                        .foregroundColor(Color.ColorPrimary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                }
                .padding(4)
                
                HStack {
                    Label {
                        Text("Arrival Airport: ")
                            .font(Font.custom("Poppins-Medium", size: Constants.TASK_HEADERS_FONT_SIZE))
                            .foregroundColor(Color.ColorPrimary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                    } icon: {
                        Image(systemName: "airplane.arrival")
                            .foregroundColor(Color.Accent)
                    }
                    
                    Text(flightTicket?.destinationAirport ?? "No arrival airport")
                        .font(Font.custom("Poppins-Regular", size: Constants.TASK_NAME_FONT_SIZE))
                        .foregroundColor(Color.ColorPrimary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                }
                .padding(4)
                
                HStack {
                    Label {
                        Text(flightTicket?.flightNumber ?? "None")
                            .font(Font.custom("Poppins-Medium", size: Constants.TASK_HEADERS_FONT_SIZE))
                            .foregroundColor(Color.ColorPrimary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                    } icon: {
                        Image(systemName: "airplane")
                            .foregroundColor(Color.Accent)
                    }
                    
                    Label {
                        Text(flightTicket?.seatNumber ?? "None")
                            .font(Font.custom("Poppins-Medium", size: Constants.TASK_NAME_FONT_SIZE))
                            .foregroundColor(Color.ColorPrimary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                    } icon: {
                        Image("flight_seat")
                            .resizable()
                            .frame(width: 20, height: 24)
                        
                    }
                }
                .padding(4)
                
                Divider()
                    .padding(8)
                    .foregroundColor(Color.LightGreyColor)
                
                if(flightTicket?.bookReturn != 0) {
                    
                    Label {
                        Text("Return Date: " + (flightTicket?.returnDate ?? "No return date"))
                            .font(Font.custom("Poppins-Medium", size: Constants.TASK_NAME_FONT_SIZE))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image("calendar")
                            .resizable()
                            .frame(width: 12, height: 12)
                    }
                    
                    HStack {
                        Label {
                            Text("Return Airport: ")
                                .font(Font.custom("Poppins-Medium", size: Constants.TASK_HEADERS_FONT_SIZE))
                                .foregroundColor(Color.ColorPrimary)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                        } icon: {
                            Image(systemName: "airplane.arrival")
                                .foregroundColor(Color.Accent)
                                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        }
                        
                        Text(flightTicket?.returnAirport ?? "No return airport")
                            .font(Font.custom("Poppins-Regular", size: Constants.TASK_HEADERS_FONT_SIZE))
                            .foregroundColor(Color.ColorPrimary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                    }
                    .padding(4)
                    
                    HStack {
                        Label {
                            Text(flightTicket?.returnFlightNumber ?? "None")
                                .font(Font.custom("Poppins-Medium", size: Constants.TASK_HEADERS_FONT_SIZE))
                                .foregroundColor(Color.ColorPrimary)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                        } icon: {
                            Image(systemName: "airplane")
                                .foregroundColor(Color.Accent)
                        }
                        
                        Label {
                            Text(flightTicket?.returnSeatNumber ?? "None")
                                .font(Font.custom("Poppins-Medium", size: Constants.TASK_HEADERS_FONT_SIZE))
                                .foregroundColor(Color.ColorPrimary)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                        } icon: {
                            Image("flight_seat")
                                .resizable()
                                .frame(width: 20, height: 24)
                        }
                    }
                    .padding(4)
                }
                
                ForEach(taskFilesURLs, id: \.self) { fileURL in
                    TaskFileViewContent(fileURL: fileURL)
                }
                
            case TicketType.GENERAL.rawValue:
                
                VStack {
                    Text("No extra details")
                    .font(Font.custom("Poppins-Light", size: Constants.TASK_HEADERS_FONT_SIZE))
                }
                
            default:
                EmptyView()
            }
            
        }
        .padding(.leading, 48)
        .padding(.trailing, 4)
        .padding(.top, 4)
        .padding(.bottom, 4)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}

public func storeFileToTemporaryFolder(fileData: Data, tempUrl: URL) {
    guard !FileManager.default.fileExists(atPath: tempUrl.path) else {
        return
    }
    do {
        try fileData.write(to: tempUrl)
    }
    catch {
        fatalError()
    }
}

public func loadFileFromTemporaryFolder(tempUrl: URL) -> Data? {
    if let data = try? Data(contentsOf: tempUrl) {
        return data
    }
    return nil
}

public func deleteFileFromTemporaryFolder(fileURL: URL) {
    do {
        try FileManager.default.removeItem(at: fileURL)
    }
    catch {
        fatalError()
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

public func copyFileToTemporaryDirectory (resourceName: String, fileExtension: String) -> URL? {
    guard let bundleURL = Bundle.main.url(forResource: resourceName, withExtension: fileExtension) else { return nil }
    let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    
    let targetURL = tempDirectoryURL.appendingPathComponent("\(resourceName).\(fileExtension)")
    do {
        try FileManager.default.copyItem(at: bundleURL, to: targetURL)
    } catch {
        print("Could not write file", error.localizedDescription)
    }
    
    return nil
}

struct TaskFileViewContent : View {
    @State var fileURL: URL
    
    var body: some View {
        return Label {
            Text(fileURL.pathExtension.capitalized)
                .font(Font.custom("Poppins-Regular", size: 14))
                .foregroundColor(Color.ColorPrimary)
        } icon: {
            Image(systemName: "doc.richtext")
                .foregroundColor(Color.ColorPrimary)
        }
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

struct TaskContentView_Previews: PreviewProvider {
    
    @State private var taskFilesURLs: [URL] =
    [
        URL(string: "https://upload.wikimedia.org/wikipedia/commons/2/20/Re_example.pdf")!,
        URL(string: "https://upload.wikimedia.org/wikipedia/commons/2/20/Re_example.pdf")!
    ]
    
    static var previews: some View {
        
        /*TaskContentView(
         selectedTask: Ticket(
         id: "123456",
         name: "Task Name",
         startDate: "2023-03-28 11:09",
         status: TicketStatus.STATUS_IN_PROGRESS.rawValue,
         ticketType: TicketType.GENERAL.rawValue))*/
        
        TaskContentView(
            selectedTask: FlightTicket(
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
            ), userId: "")
    }
}
