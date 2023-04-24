//
//  ScreenTitleView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/24.
//

import SwiftUI

struct ScreenTitleView: View {
    
    var screenTitle: String
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Text(screenTitle)
                .font(Font.custom("Poppins-Bold", size: 16))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.leading, 24)
                .padding(.trailing, 24)
                .padding(.top, 2)
                .padding(.bottom, 4)
            
            Divider()
                .frame(height: 3)
                .overlay(Color.gray)
                .padding(.leading, 24)
                .padding(.trailing, 24)
                .padding(.top, 0)
            
        }
        .padding(.top, 0)
        
    }
    
}

struct ScreenTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenTitleView(screenTitle: "Screen Name")
    }
}
