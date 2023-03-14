import SwiftUI

struct TimelineView: View {
    
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    let primaryBlack = Color(red: 31.0/255.0, green: 34.0/255.0, blue: 41.0/255.0, opacity: 1.0)
    
    var body: some View {
        let tasks: [String] = ["Sky diving trip", "Laundry run", "Flight to Mali", "Golf", "Birthday Present Delivery"]
        NavigationView{
            VStack{
                List {
                    ForEach(0..<5) { toto in
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
                                    Text(tasks[toto])
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
                }
            }
            .navigationTitle("Timeline")
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
