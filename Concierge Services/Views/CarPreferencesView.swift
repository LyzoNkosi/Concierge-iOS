//
//  CarPreferencesView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/11.
//

import SwiftUI

struct CarPreferencesView: View {
    
    // Car Rental
    @State var carCompany: String = ""
    @State var carType: String = ""
    @State var carProgram: String = ""
    @State var carProgramNumber: String = ""
    @State var carRentalRequests: String = ""
    
    @State var buttonText: String = "Edit"
    
    @State var inEditMode: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                // Car & Taxi Prefs
                VStack(alignment: .leading) {
                    
                    Label {
                        Text("Car Preferences")
                            .font(Font.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image(systemName: "car.fill")
                            .foregroundColor(Color.Accent)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Car Rental Company")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        CarRentalCompanyInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Car Type")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        CarTypeInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Rental Car Rewards Program")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        CarProgramNameInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Rental Car Rewards Number")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        CarProgramNumberInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Car Rental Special Requests/Needs")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        CarRentalRequestsInput()
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
    
    // Car Rental Prefs
    fileprivate func CarRentalCompanyInput() -> some View {
        TextField("Car Rental Company", text: $carCompany)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func CarTypeInput() -> some View {
        TextField("Car Type", text: $carType)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func CarProgramNameInput() -> some View {
        TextField("Car Rental Rewards Program", text: $carProgram)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func CarProgramNumberInput() -> some View {
        TextField("Car Rental Rewards Number", text: $carProgramNumber)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func CarRentalRequestsInput() -> some View {
        TextField("Car Rental Special Needs/Requests", text: $carRentalRequests)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
}

struct CarPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        CarPreferencesView()
    }
}
