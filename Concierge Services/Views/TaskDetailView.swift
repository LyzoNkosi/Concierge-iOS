import SwiftUI
import Firebase
import Foundation
import AlertToast
import MobileCoreServices
import FirebaseCore
import FirebaseStorage

struct TaskDetailView: View {
    
    var selectedTask: Ticket
    var userId: String
    
    @State private var showToast = false
    @State private var toastMessage = ""
    
    @State private var taskFilesURLs: [URL] = []
    
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
                                    .frame(width: 1, height: 10, alignment: .center)
                                Circle()
                                    .frame(width: 10, height: 10)
                                Rectangle()
                                    .frame(width: 1, height: 10, alignment: .center)
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
                                    .frame(width: 1, height: 10, alignment: .center)
                                    .foregroundColor(Color.ColorPrimary)
                            }
                            .frame(width: 32, height: 80, alignment: .center)
                            .foregroundColor(Color.ColorPrimary)
                            
                            VStack(alignment: .leading, content: {
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
                                    .font(Font.custom("Poppins-Medium", size: 24))
                                    .foregroundColor(Color.ColorPrimary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                
                            })
                        }
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .padding(.bottom, 12)
                        
                        Divider()
                            .padding(8)
                            .foregroundColor(Color.LightGreyColor)
                        
                        HStack {
                            Label {
                                Text("Destination: ")
                                    .font(Font.custom("Poppins-Bold", size: 16))
                                    .foregroundColor(Color.ColorPrimary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                            } icon: {
                                Image(systemName: "figure.walk.arrival")
                                    .foregroundColor(Color.Accent)
                            }
                            
                            Text(flightTicket?.destination ?? "No arrival airport")
                                .font(Font.custom("Poppins-Regular", size: 18))
                                .foregroundColor(Color.ColorPrimary)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                        }
                        .padding(4)
                        
                        HStack {
                            Label {
                                Text("Departure Airport: ")
                                    .font(Font.custom("Poppins-Bold", size: 14))
                                    .foregroundColor(Color.ColorPrimary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                            } icon: {
                                Image(systemName: "airplane.departure")
                                    .foregroundColor(Color.Accent)
                            }
                            
                            Text(flightTicket?.departureAirport ?? "No departure airport")
                                .font(Font.custom("Poppins-Regular", size: 16))
                                .foregroundColor(Color.ColorPrimary)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                        }
                        .padding(4)
                        
                        HStack {
                            Label {
                                Text("Arrival Airport: ")
                                    .font(Font.custom("Poppins-Bold", size: 14))
                                    .foregroundColor(Color.ColorPrimary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                            } icon: {
                                Image(systemName: "airplane.arrival")
                                    .foregroundColor(Color.Accent)
                            }
                            
                            Text(flightTicket?.destinationAirport ?? "No arrival airport")
                                .font(Font.custom("Poppins-Regular", size: 16))
                                .foregroundColor(Color.ColorPrimary)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                        }
                        .padding(4)
                        
                        HStack {
                            Label {
                                Text(flightTicket?.flightNumber ?? "None")
                                    .font(Font.custom("Poppins-Bold", size: 14))
                                    .foregroundColor(Color.ColorPrimary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                            } icon: {
                                Image(systemName: "airplane")
                                    .foregroundColor(Color.Accent)
                            }
                            
                            Label {
                                Text(flightTicket?.seatNumber ?? "None")
                                    .font(Font.custom("Poppins-Bold", size: 14))
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
                                    .font(Font.custom("Poppins-Regular", size: 14))
                                    .foregroundColor(Color.ColorPrimary)
                            } icon: {
                                Image("calendar")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                            
                            HStack {
                                Label {
                                    Text("Return Airport: ")
                                        .font(Font.custom("Poppins-Bold", size: 14))
                                        .foregroundColor(Color.ColorPrimary)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                } icon: {
                                    Image(systemName: "airplane.arrival")
                                        .foregroundColor(Color.Accent)
                                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                }
                                
                                Text(flightTicket?.returnAirport ?? "No return airport")
                                    .font(Font.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color.ColorPrimary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                            }
                            .padding(4)
                            
                            HStack {
                                Label {
                                    Text(flightTicket?.returnFlightNumber ?? "None")
                                        .font(Font.custom("Poppins-Bold", size: 14))
                                        .foregroundColor(Color.ColorPrimary)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                } icon: {
                                    Image(systemName: "airplane")
                                        .foregroundColor(Color.Accent)
                                }
                                
                                Label {
                                    Text(flightTicket?.returnSeatNumber ?? "None")
                                        .font(Font.custom("Poppins-Bold", size: 14))
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
                        
                        //})
                        //}.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                    case TicketType.GENERAL.rawValue:
                        
                        HStack(alignment: .top, spacing: 0) {
                            VStack(alignment: .center, spacing: 0) {
                                Rectangle()
                                    .frame(width: 1, height: 10, alignment: .center)
                                Circle()
                                    .frame(width: 10, height: 10)
                                Rectangle()
                                    .frame(width: 1, height: 10, alignment: .center)
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color.Accent)
                                    .overlay(
                                        Image("hourglass")
                                            .resizable()
                                            .frame(width: 18, height: 18)
                                    )
                                Rectangle()
                                    .frame(width: 1, height: 10, alignment: .center)
                                    .foregroundColor(Color.ColorPrimary)
                            }
                            .frame(width: 32, height: 80, alignment: .center)
                            .foregroundColor(Color.ColorPrimary)
                            
                            VStack(alignment: .leading, content: {
                                Label {
                                    Text(selectedTask.startDate ?? "No departure date")
                                        .font(Font.custom("Poppins-Regular", size: 14))
                                        .foregroundColor(Color.ColorPrimary)
                                } icon: {
                                    Image("calendar")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                                
                                Text(selectedTask.name ?? "")
                                    .font(Font.custom("Poppins-Medium", size: 24))
                                    .foregroundColor(Color.ColorPrimary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                
                            })
                        }
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .padding(.bottom, 12)
                        
                        Divider()
                            .padding(8)
                            .foregroundColor(Color.LightGreyColor)
                        
                        HStack {
                            // Add attachments here
                            
                        }
                        
                        
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
        .onAppear {
            FirebaseStorageManager().listAllFiles(userId: userId, ownerId: selectedTask.id!) { loadedFiles in
                self.taskFilesURLs = loadedFiles
                print("Loaded files: ", loadedFiles)
            }
        }
        .padding()
        .navigationTitle("Task Details")
        .font(Font.custom("Poppins-Regular", size: 20))
        .toolbar {
            Menu("Options") {
                Button("Add File", action: uploadFile)
                //Button("Edit Task", action: editTask)
                //Button("Cancel Task", action: cancelTask)
            }
        }
    }
    
    private func uploadFile() {
        
        let picker = DocumentPickerViewController(
            supportedTypes: [String(kUTTypePNG), String(kUTTypeJPEG), String(kUTTypePDF)],
            onPick: { url in
                print("url : \(url)")
                
                let tempUrl = FileManager.default.temporaryDirectory.appendingPathComponent(String(Date().millisecondsSince1970) + "." + url.pathExtension)
                
                let docData = try? Data(contentsOf: url)
                
                storeFileToTemporaryFolder(fileData: docData!, tempUrl: tempUrl)
                
                FirebaseStorageManager().uploadFile(
                    fileUrl: tempUrl,
                    userId: userId,
                    ownerId: selectedTask.id!) { uploadedFileURL in
                        if(uploadedFileURL != nil) {
                            
                            deleteFileFromTemporaryFolder(fileURL: tempUrl)
                            
                            self.toastMessage = "File uploaded"
                            self.showToast = true
                            
                            taskFilesURLs.append(uploadedFileURL!)
                        } else {
                            self.toastMessage = "Error uploading file"
                            self.showToast = true
                            
                            return
                        }
                    }
                
            },
            onDismiss: {
                print("dismiss")
            }
        )
        picker.allowsMultipleSelection = false
        
        UIApplication.shared.windows.first?.rootViewController?.present(picker, animated: true)
    }
    
    private func editTask() { }
    
    private func cancelTask() { }
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

struct TaskDetailView_Previews: PreviewProvider {
    @State private var taskFilesURLs: [URL] =
    [
        URL(string: "https://upload.wikimedia.org/wikipedia/commons/2/20/Re_example.pdf")!,
        URL(string: "https://upload.wikimedia.org/wikipedia/commons/2/20/Re_example.pdf")!
    ]
    
    static var previews: some View {
        /*TaskDetailView(
         selectedTask: Ticket(
         id: "123456",
         name: "Task Name",
         startDate: "2023-03-28 11:09",
         status: TicketStatus.STATUS_IN_PROGRESS.rawValue,
         ticketType: TicketType.GENERAL.rawValue))*/
        TaskDetailView(
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
