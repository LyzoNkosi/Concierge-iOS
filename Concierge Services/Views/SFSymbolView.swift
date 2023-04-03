import SwiftUI

struct SFSymbolView: View {
    //let symbol: SFSymbol
    @State var activityItem : ActivityItem
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: activityItem.image)
                .resizable()
                .frame(maxHeight: .infinity)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.ColorPrimary)
            Text(activityItem.name)
                .font(Font.custom("Poppins-Bold", size: 26))
                .foregroundColor(Color.ColorPrimary)
            Spacer()
        }
        .padding()
    }
}

struct SFSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        SFSymbolView(activityItem: ActivityItem(image: "airplane", name: "Airplane"))
    }
}
