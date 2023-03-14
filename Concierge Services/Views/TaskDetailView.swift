import SwiftUI

struct TaskDetailView: View {
    var body: some View {
        NavigationView{
            VStack (alignment: .leading, spacing: 8){
                
                HStack {
                    Image(systemName: "car").frame(width: 24, height: 24)
                    Text("Trip to Mars on Amazon Blue space-flight")
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 8){
                    Label {
                        Text("14:04")
                            .font(.subheadline)
                    } icon: {
                        Image(systemName: "calendar.badge.clock")
                    }
                    .padding()
                    
                    Label {
                        Text("Boarding Pass")
                            .font(.subheadline)
                    } icon: {
                        Image(systemName: "square.and.arrow.down")
                    }
                    .padding()
                    
                }
                
                
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            .navigationTitle("Task Details")
            
            .safeAreaInset(edge: .bottom) {
                HStack(alignment: .center, spacing: 8){
                    EditTaskButtonContent()
                    CancelTaskButtonContent()
                }
                
            } .padding(12)
            
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
        TaskDetailView()
    }
}
