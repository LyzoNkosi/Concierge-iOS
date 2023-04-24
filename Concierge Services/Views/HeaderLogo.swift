//
//  HeaderLogo.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/24.
//

import SwiftUI

struct HeaderLogo : View {
    var body: some View {
        return VStack(alignment: .trailing) {
            Image("african_sun_logo_no_bg")
                .resizable()
                .frame(width: 148, height: 132)
                .padding(.top, 8)
            
        }
    }
}

struct HeaderLogo_Previews: PreviewProvider {
    static var previews: some View {
        HeaderLogo()
    }
}
