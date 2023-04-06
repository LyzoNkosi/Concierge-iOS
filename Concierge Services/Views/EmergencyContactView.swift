//
//  EmergencyContactView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/06.
//

import SwiftUI

struct EmergencyContactView: View {
    
    // Kin
    @State var kinName: String = ""
    @State var kinAddress: String = ""
    @State var kinHomePhone: String = ""
    @State var kinCellphone: String = ""
    @State var kinEmail: String = ""
    
    @State var buttonText: String = "Edit"
    
    @State var inEditMode: Bool = false
    
    var body: some View {
        
        ScrollView {
            VStack {
                // Next of Kin
                VStack(alignment: .leading) {
                    
                    Label {
                        Text("Emergency Contact")
                            .font(Font.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image(systemName: "phone.fill")
                            .foregroundColor(Color.Accent)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Contact Person")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        KinNameInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Contact Person Address")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        KinAddressInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Contact Person Home Phone")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        KinHomePhoneInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Contact Person Cellphone")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        KinCellphoneInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Contact Person EMail")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        KinEmailInput()
                    }
                    .padding()
                }
            }
        }
        .toolbar {
            Button(self.buttonText) {
                if(self.inEditMode) {
                    self.inEditMode = false
                    self.buttonText = "Edit"
                } else {
                    self.inEditMode = true
                    self.buttonText = "Save"
                }
            }
        }
    }
    
    // Next of Kin
    
    fileprivate func KinNameInput() -> some View {
        TextField("Contact Person", text: $kinName)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func KinAddressInput() -> some View {
        TextField("Contact Address", text: $kinAddress)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func KinHomePhoneInput() -> some View {
        TextField("Contact Person Home Phone", text: $kinHomePhone)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func KinCellphoneInput() -> some View {
        TextField("Contact Person Cellphone", text: $kinCellphone)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func KinEmailInput() -> some View {
        TextField("Contact Person Email", text: $kinEmail)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
}

struct EmergencyContactView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyContactView()
    }
}
