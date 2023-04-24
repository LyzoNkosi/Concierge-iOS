//
//  PaymentMethodView.swift
//  Concierge Services
//
//  Created by mac on 2023/04/24.
//

import SwiftUI

struct PaymentMethodView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            UserToolbarView()
            
            ScreenTitleView(screenTitle: "Payment Methods")
                .padding(.top, 0)
            
            NavigationLink(destination:PlaceholderView()){
                HStack {
                    Image("credit_card")
                        .resizable()
                        .frame(width: 24, height: 18)
                        .padding(2)
                    VStack{
                        Text("Credit Card")
                            .font(Font.custom("Poppins-Regular", size: 10))
                            .foregroundColor(Color.ColorPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("DP Naidoo")
                            .font(Font.custom("Poppins-Regular", size: 10))
                            .foregroundColor(Color.ColorPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("4790 XXXX XXXX XX19")
                            .font(Font.custom("Poppins-Regular", size: 10))
                            .foregroundColor(Color.ColorPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    Text("Expiry Date")
                        .font(Font.custom("Poppins-Regular", size: 10))
                        .foregroundColor(Color.ColorPrimary)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                

            }
            .padding()
          Spacer()
        }
        
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                HeaderLogo()
            }
        }
    }
}

struct PaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethodView()
    }
}
