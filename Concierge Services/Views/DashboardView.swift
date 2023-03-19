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

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
