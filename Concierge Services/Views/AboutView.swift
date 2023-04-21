//
//  AboutView.swift
//  Concierge Services
//
//  Created by Slindelo Mathenjwa on 2023/04/13.
//
import SwiftUI
import WebKit



struct AboutView: View {
    @State var openContactScreen = false
    @State var openLicenseScreen = false
    
    var body: some View {
        
        ScrollView {
            VStack(){
                
                VStack(alignment: .leading, spacing: 24) {
                    AfricanSun()
                        .padding(5)
                }
                VStack(alignment: .center ) {
                    
                    Text("version 1.0.a")
                        .font(Font.custom("Poppins-Regular", size: 18))
                        .padding()
                    
                    Button(action: {
                        self.openContactScreen = true
                        
                    }, label: {
                        Text("Contact Us")
                            .font(Font.custom("Poppins-Regular", size: 18))
                            .frame(width: 100, height: 0)
                            .padding()
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        
                        NavigationLink(destination: ContactUsView(), isActive: $openContactScreen) {}
                        NavigationLink(destination: PlaceholderView(), isActive: $openLicenseScreen) {}
                    })
                    
                    .padding()
                    
                    //Licenses
                    Button(action: {
                        self.openLicenseScreen = true
                    }, label: {
                        Text("Licenses")
                            .font(Font.custom("Poppins-Regular", size: 18))
                            .frame(width: 100, height: 0)
                            .padding()
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    })
                    
                    .padding()
                    Text("© 2023 Norrinradd")
                        .font(Font.custom("Poppins-Bold", size: 14))
                        .padding(140)
                }
                
            }
        }
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
