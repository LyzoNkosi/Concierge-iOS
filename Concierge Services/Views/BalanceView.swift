import SwiftUI

struct BalanceView: View {
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading, spacing: 24) {
                
                HStack {
                    Text("Card Name")
                        .font(.system(size: 20, weight: .semibold, design: .monospaced))
                    Spacer()
                    Image("mastercard")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .clipped()
                        .cornerRadius(4)
                }
                
                VStack(spacing: 6) {
                    HStack {
                        Text("1234  5678  9101  1112")
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                    }
                    
                }
                
                HStack {
                    Text("Card holder")
                        .font(.system(size: 14, weight: .light, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Expires")
                        .font(.system(size: 14, weight: .light, design: .serif))
                    Text("CVV")
                        .font(.system(size: 14, weight: .light, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                HStack {
                    Text("Some User")
                        .font(.system(size: 14, weight: .light, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("12/24")
                        .font(.system(size: 14, weight: .light, design: .serif))
                    Text("123")
                        .font(.system(size: 14, weight: .light, design: .serif))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
            }
            .foregroundColor(.white)
            .padding()
            .background(
                Image("card_bg")
                    .resizable()
            )
            .overlay(RoundedRectangle(cornerRadius: 12)
                .stroke(primaryBlack.opacity(0.0), lineWidth: 0.5)
            )
            .cornerRadius(6)
            .shadow(radius: 5)
            .padding(.horizontal)
            .padding(.top, 8)
            
            Spacer()
            
                .safeAreaInset(edge: .bottom) {
                    PayButtonContent()
                } .padding(12)
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .navigationTitle("Balance")
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView()
    }
}

struct PayButtonContent : View {
    var body: some View {
        return Text("Make Payment")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(primaryBlack)
            .cornerRadius(15.0)
    }
}
