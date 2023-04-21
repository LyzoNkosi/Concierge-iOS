//
//  ContactUsView.swift
//  Concierge Services
//
//  Created by Slindelo Mathenjwa on 2023/04/13.
//
import SwiftUI

struct ContactUsView: View {
    @State private var isPresented = false


    let whatsappNumber = "15551234567"

    let recipientEmail = "info@concierge.com"
    let subject = "Message from my SwiftUI app"
    let bodyy = "Hello"

    var body: some View {
        NavigationView {

            VStack{

                List {
                    //CALL US
                    HStack {
                        Image(systemName: "phone")
                            .font(Font.custom("Poppins-Regular", size: 18))
                        Text("Call Us")
                            .onTapGesture {
                                self.isPresented = true
                            }
                    }


                    //EMAIL US
                    HStack {
                        Image(systemName: "tray.fill")
                            .font(Font.custom("Poppins-Regular", size: 18))
                        Text("Email Us")
                            .onTapGesture {
                                if let url = URL(string: "mailto:\(recipientEmail)")
                                {
                                UIApplication.shared.open(url)
                               }
                            }
                    }

                    //CHAT ON WHATSAPP
                    
                    HStack {
                        Image(systemName: "message.circle")
                            .font(Font.custom("Poppins-Regular", size: 18))
                        Text("Chat on WhatsApp")
                            .onTapGesture {
                                let urlString = "https://api.whatsapp.com/send?phone=\(whatsappNumber)"
                                let url = URL(string: urlString)!

                                if UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url)
                                } else {
                                    print("Unable to open WhatsApp")
                                }
                            }
                    }

                }
                BottomSheetView(isPresented: $isPresented)

            }
            .navigationBarTitle("Contact Us")
            .navigationBarHidden(true)
        }
    }
    //Call Us
    struct BottomSheetView: View {
        @Binding var isPresented: Bool
        var phoneNumber = "(123) 456-7890"
        var body: some View {
            VStack {

                Text("Call \(phoneNumber)?")
                    .font(Font.custom("Poppins-Regular", size: 20))
                    .padding()

                Divider()

                HStack {
                    Spacer()

                    Button(action: {
                        if let url = URL(string: "tel:\(phoneNumber)")
                        {
                      UIApplication.shared.open(url)
                      }
                    }) {
                        Image(systemName: "phone")
                        Text("Call")
                            .fontWeight(.semibold)
                            .padding()

                    }

                    Spacer()

                    Button(action: {
                        self.isPresented.toggle()
                    }) {
                        Text("Cancel")
                            .fontWeight(.semibold)
                            .padding()
                    }

                    Spacer()
                }
            }

            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.vertical)
            .padding(.bottom, isPresented ? 20 : -500)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
