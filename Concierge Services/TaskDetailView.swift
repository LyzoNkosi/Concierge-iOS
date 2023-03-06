//
//  TaskDetailView.swift
//  Concierge Services
//
//  Created by Mac on 2023/03/06.
//

import SwiftUI

struct TaskDetailView: View {
    var body: some View {
        NavigationView{
            VStack{
                
                HStack {
                    Image(systemName: "car").frame(width: 24, height: 24)
                    Text("Trip to Mars on Amazon Blue space-flight")
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                }
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            .navigationTitle("Task Details")
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView()
    }
}
