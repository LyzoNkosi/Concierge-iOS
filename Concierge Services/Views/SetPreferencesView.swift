import SwiftUI

struct SetPreferencesView: View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        
        ScrollView {
            
            LazyVGrid(columns: columns, spacing: 20) {
                
                ForEach(ActivityItem.sports, id: \.self) { sport in
                    makeGridItemImageWithText(activityItem: sport)
                }
                
            }
            
        }
    }
}

struct makeGridItemImageWithText : View {
    
    @State var activityItem : ActivityItem
    
    var body: some View {
        return ZStack {
            Rectangle()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [Color.ColorPrimary, Color.ColorSecondary]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(16)
            
            VStack() {
                Image(systemName: "books.vertical.circle")
                    .foregroundColor(.white)
                    .font(.system(size: 84))
                
                Text("upcoming tasks")
                    .padding(4)
                    .font(Font.custom("Poppins-Light", size: 16))
                    .foregroundColor(Color.TextColorPrimary)
            }
            .padding(4)
        }
    }
}

struct SetPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        SetPreferencesView()
    }
}
