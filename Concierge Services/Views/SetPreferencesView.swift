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
            .padding()
        }
    }
}

struct makeGridItemImageWithText : View {
    
    @State var activityItem : ActivityItem
    
    var body: some View {
        return ZStack(alignment: .center) {
            Rectangle()
                .frame(minWidth: 0, maxWidth: 128)
                .background(LinearGradient(gradient: Gradient(colors: [Color.ColorPrimary, Color.ColorSecondary]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(16)
            
            VStack() {
                Image(systemName: activityItem.image)
                    .foregroundColor(.white)
                    .font(.system(size: 64))
                
                Spacer()
                
                Text(activityItem.name)
                    .font(Font.custom("Poppins-Light", size: 15))
                    .foregroundColor(Color.TextColorPrimary)
                    .padding()
            }
        }
    }
}

struct SetPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        SetPreferencesView()
    }
}
