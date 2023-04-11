//
//  AirlinePreferencesView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/06.
//

import SwiftUI

struct AirlinePreferencesView: View {
    
    // Airline
    @State var airline: String = ""
    @State var seatingClass: String = ""
    @State var seatType: String = ""
    @State var flightMeal: String = ""
    @State var flightSpecialNeeds: String = ""
    @State var flightProgram: String = ""
    @State var flightProgramName: String = ""
    @State var flightProgramNumber: String = ""
    
    @State var buttonText: String = "Edit"
    
    @State var notInEditMode: Bool = true
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                // Airline Prefs
                VStack(alignment: .leading) {
                    
                    Label {
                        Text("Airline Preferences")
                            .font(Font.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image(systemName: "airplane")
                            .foregroundColor(Color.Accent)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Airline")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        AirlineInput()
                    }
                    .padding()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Seating Class")
                                .font(Font.custom("Poppins-Regular", size: 14))
                                .foregroundColor(Color.ColorPrimary)
                            SeatingClassInput()
                        }
                        .padding()
                        
                        VStack(alignment: .leading) {
                            Text("Seat Type")
                                .font(Font.custom("Poppins-Regular", size: 14))
                                .foregroundColor(Color.ColorPrimary)
                            SeatTypeInput()
                        }
                        .padding()
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Preffered Meal")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        FlightMealInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Flight Special Needs/Requests")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        FlightSpecialNeedsInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Frequent Flyer Program")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        FlyerProgramInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Frequent Flyer Name")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        FlyerProgramNameInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Frequent Flyer Number")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        FlyerProgramNumberInput()
                    }
                    .padding()
                }
            }
            
        }
        .toolbar {
            Button(self.buttonText) {
                if(self.notInEditMode) {
                    self.notInEditMode = true
                    self.buttonText = "Edit"
                } else {
                    self.notInEditMode = false
                    self.buttonText = "Save"
                }
            }
        }
    }
    
    // Airline Prefs
    fileprivate func AirlineInput() -> some View {
        TextField("Airline", text: $airline)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(notInEditMode)
    }
    
    fileprivate func SeatingClassInput() -> some View {
        TextField("Seating Class", text: $seatingClass)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(notInEditMode)
    }
    
    fileprivate func SeatTypeInput() -> some View {
        TextField("Seat Type", text: $seatType)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(notInEditMode)
    }
    
    fileprivate func FlightMealInput() -> some View {
        TextField("Flight Diet", text: $flightMeal)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(notInEditMode)
    }
    
    fileprivate func FlightSpecialNeedsInput() -> some View {
        TextField("Flight Special Needs/Requests", text: $flightSpecialNeeds)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(notInEditMode)
    }
    
    fileprivate func FlyerProgramInput() -> some View {
        TextField("Frequent Flyer Program", text: $flightProgram)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(notInEditMode)
    }
    
    fileprivate func FlyerProgramNameInput() -> some View {
        TextField("Frequent Flyer Program Name", text: $flightProgramName)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(notInEditMode)
    }
    
    fileprivate func FlyerProgramNumberInput() -> some View {
        TextField("Frequent Flyer Number", text: $flightProgramNumber)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(notInEditMode)
    }
}

struct AirlinePreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        AirlinePreferencesView()
    }
}
