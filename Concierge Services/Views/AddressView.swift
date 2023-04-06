//
//  AddressView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/06.
//

import SwiftUI

struct AddressView: View {
    
    // Address
    @State var street: String = ""
    @State var city: String = ""
    @State var province: String = ""
    @State var zip: String = ""
    @State var homePhone: String = ""
    @State var cellphone: String = ""
    @State var workPhone: String = ""
    @State var altEmail: String = ""
    
    @State var buttonText: String = "Edit"
    
    @State var inEditMode: Bool = false
    
    var body: some View {
        
        ScrollView {
            VStack {
                // Address
                VStack(alignment: .leading) {
                    
                    Label {
                        Text("Address")
                            .font(Font.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image(systemName: "house.fill")
                            .foregroundColor(Color.Accent)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Street Address")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        StreetInput()
                    }
                    .padding()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("City")
                                .font(Font.custom("Poppins-Regular", size: 14))
                                .foregroundColor(Color.ColorPrimary)
                            CityInput()
                        }
                        .padding()
                        
                        VStack(alignment: .leading) {
                            Text("Province/State")
                                .font(Font.custom("Poppins-Regular", size: 14))
                                .foregroundColor(Color.ColorPrimary)
                            ProvinceInput()
                        }
                        .padding()
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Postal Code")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        ZipInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Cellphone")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        CellphoneInput()
                    }
                    .padding()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Home Phone")
                                .font(Font.custom("Poppins-Regular", size: 14))
                                .foregroundColor(Color.ColorPrimary)
                            HomePhoneInput()
                        }
                        .padding()
                        
                        VStack(alignment: .leading) {
                            Text("Work Phone")
                                .font(Font.custom("Poppins-Regular", size: 14))
                                .foregroundColor(Color.ColorPrimary)
                            WorkPhoneInput()
                        }
                        .padding()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Alternate EMail")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        AltEmailInput()
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
    
    // Address
    fileprivate func StreetInput() -> some View {
        TextField("Street", text: $street)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func CityInput() -> some View {
        TextField("City", text: $city)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func ProvinceInput() -> some View {
        TextField("Province/State", text: $province)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func ZipInput() -> some View {
        TextField("Postal Code", text: $zip)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func HomePhoneInput() -> some View {
        TextField("Home Phone", text: $homePhone)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func CellphoneInput() -> some View {
        TextField("Cellphone", text: $cellphone)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func WorkPhoneInput() -> some View {
        TextField("Work Phone", text: $workPhone)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func AltEmailInput() -> some View {
        TextField("Alternate Email", text: $altEmail)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
    }
}
