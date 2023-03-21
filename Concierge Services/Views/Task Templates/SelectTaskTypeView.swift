import SwiftUI

struct SelectTaskTypeView: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    var body: some View {
        
        VStack {
            
            List {
                // 1
                NavigationLink(destination: CreateTaskView().environmentObject(firestoreManager)) {
                    HStack {
                        Image(systemName: "plus.square.on.square")
                        Text("General")
                    }
                }
                // 2
                NavigationLink(destination: CreateFlightTaskView().environmentObject(firestoreManager)) {
                    HStack {
                        Image(systemName: "airplane")
                        Text("Flight")
                    }
                }
            }
        }
        .navigationBarTitle("Task Type")
    }
        
}

struct SelectTaskTypeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTaskTypeView()
    }
}
