//
//  CollapsibleView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/14.
//

import SwiftUI

struct CollapsibleView<TaskContentView: View>: View {
    @State var label: () -> TaskHeaderView
    @State var content: () -> TaskContentView
    
    @State private var collapsed: Bool = true
    
    var body: some View {
        
        HStack {
            self.label()
            Spacer()
            //Image(systemName: self.collapsed ? "chevron.down" : "chevron.up")
        }
        .onTapGesture {
            self.collapsed.toggle()
        }
        .padding(.bottom, 1)
        .background(Color.white.opacity(0.01))
        
        VStack {
            self.content()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
        .clipped()
        .animation(Animation.easeInOut(duration: 0.35), value: collapsed)
        //.animation(Animation.easeInOut(duration: 1.0), value: offset)
        .transition(.slide)
    }
}
