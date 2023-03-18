import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {
            EmptyBoxImage()
            
            ChatButtonContent()
        }
        .navigationTitle("Dashboard")
    }
}

struct EmptyBoxImage : View {
    
    var body: some View {
        return Image("empty_box")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 196, height: 196)
            .clipped()
            .padding(.bottom, 75)
    }
}

struct ChatButtonContent : View {
    var body: some View {
        return Text("Chat with Agent")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(primaryBlack)
            .cornerRadius(15.0)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
