//
//  HotelPreferencesView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/06.
//

import SwiftUI

struct HotelPreferencesView: View {
    
    // Hotel
    @State var hotelChain: String = ""
    @State var hotelRequests: String = ""
    @State var hotelDietRequests: String = ""
    @State var hotelBedCount: String = ""
    @State var hotelBedSize: String = ""
    @State var hotelPillow: String = ""
    @State var hotelSmoking: String = ""
    @State var hotelPets: String = ""
    
    @State var buttonText: String = "Edit"
    
    @State var inEditMode: Bool = false
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                // Hotel Prefs
                VStack(alignment: .leading) {
                    
                    Label {
                        Text("Hotel Preferences")
                            .font(Font.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image(systemName: "building.2.fill")
                            .foregroundColor(Color.Accent)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Hotel Chain")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        HotelChainInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Hotel Special Requests/Needs")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        HotelRequestsInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Hotel Dietary Requests")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        HotelDietRequestsInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Hotel Bed Count")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        HotelBedCountInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Hotel Bed Size")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        HotelBedSizeInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Hotel Pillow Type")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        HotelPillowTypeInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Smoking Preference")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        HotelSmokingInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Pets")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        HotelPetsInput()
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
    
    // Hotel Prefs
    fileprivate func HotelChainInput() -> some View {
        TextField("Hotel Chain", text: $hotelChain)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func HotelRequestsInput() -> some View {
        TextField("Hotel Special Requests/Needs", text: $hotelRequests)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func HotelDietRequestsInput() -> some View {
        TextField("Hotel Diet", text: $hotelDietRequests)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func HotelBedCountInput() -> some View {
        TextField("Hotel Bed Count", text: $hotelBedCount)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func HotelBedSizeInput() -> some View {
        TextField("Hotel Bed Size", text: $hotelBedSize)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func HotelPillowTypeInput() -> some View {
        TextField("Hotel Pillow Type", text: $hotelPillow)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func HotelSmokingInput() -> some View {
        TextField("Hotel Smoking Preference", text: $hotelSmoking)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func HotelPetsInput() -> some View {
        TextField("Hotel Pets Preference", text: $hotelPets)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
}

struct HotelPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        HotelPreferencesView()
    }
}
