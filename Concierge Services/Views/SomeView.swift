//
//  SomeView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/24.
//

import SwiftUI

struct SomeView: View {
    var body: some View {
        VStack(alignment: .leading) {
        
            
                UserToolbarView()
            
            
            ScreenTitleView(screenTitle: "Some View")
                .padding(.top, 0)
            
            
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                HeaderLogo()
            }
        }
    }
}

struct SomeView_Previews: PreviewProvider {
    static var previews: some View {
        SomeView()
    }
}
