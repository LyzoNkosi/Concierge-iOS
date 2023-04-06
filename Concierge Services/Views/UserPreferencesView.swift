//
//  UserPreferencesView.swift
//  Concierge Services
//
//  Created by Van Lee Chigwada on 2023/04/05.
//

import SwiftUI

struct UserPreferencesView: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @State var placeholderText: String = "Placeholder"
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var idNumber: String = ""
    @State var dob: String = ""
    @State var passportNumber: String = ""
    
    // Address
    @State var street: String = ""
    @State var city: String = ""
    @State var province: String = ""
    @State var zip: String = ""
    @State var homePhone: String = ""
    @State var cellphone: String = ""
    @State var workPhone: String = ""
    @State var altEmail: String = ""
    
    // Kin
    @State var kinName: String = ""
    @State var kinAddress: String = ""
    @State var kinHomePhone: String = ""
    @State var kinCellphone: String = ""
    @State var kinEmail: String = ""
    
    // Airline
    @State var airline: String = ""
    @State var seatingClass: String = ""
    @State var seatType: String = ""
    @State var flightMeal: String = ""
    @State var flightSpecialNeeds: String = ""
    @State var flightProgram: String = ""
    @State var flightProgramName: String = ""
    @State var flightProgramNumber: String = ""
    
    // Hotel
    @State var hotelChain: String = ""
    @State var hotelRequests: String = ""
    @State var hotelDietRequests: String = ""
    @State var hotelBedCount: String = ""
    @State var hotelBedSize: String = ""
    @State var hotelPillow: String = ""
    @State var hotelSmoking: String = ""
    @State var hotelPets: String = ""
    
    // Car Rental
    @State var carCompany: String = ""
    @State var carType: String = ""
    @State var carProgram: String = ""
    @State var carProgramNumber: String = ""
    @State var carRentalRequests: String = ""
    
    
    
    var body: some View {
        
        ScrollView {
            VStack {
                
                VStack(alignment: .leading, spacing: 24) {
                    ProfileImage()
                        .padding(16)
                }
                
                // Personal Details
                VStack(alignment: .leading) {
                    Label {
                        Text("Personal Details")
                            .font(Font.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image(systemName: "person.fill")
                            .foregroundColor(Color.Accent)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("First Name")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        FirstNameInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Last Name")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        LastNameInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        UserEmailInput()
                    }
                    .padding()
                    
                }
                
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
                    
                    VStack(alignment: .leading) {
                        Text("Postal Code")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        ZipInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Home Phone")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        HomePhoneInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Cellphone")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        CellphoneInput()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Work Phone")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        WorkPhoneInput()
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
                
                // Activities
                VStack(alignment: .leading) {
                    
                    Label {
                        Text("Activity Preferences")
                            .font(Font.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color.ColorPrimary)
                    } icon: {
                        Image(systemName: "figure.disc.sports")
                            .foregroundColor(Color.Accent)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Activity")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color.ColorPrimary)
                        PlaceholderInput()
                    }
                    .padding()
                    
                }
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        }
        .navigationTitle("Profile")
    }
    
    fileprivate func PlaceholderInput() -> some View {
        TextField("Placeholder", text: $placeholderText)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    // Personal Details
    fileprivate func FirstNameInput() -> some View {
        TextField(UserDefaultsUtils.shared.getUserFirstName(), text: $firstName)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func LastNameInput() -> some View {
        TextField(UserDefaultsUtils.shared.getUserLastName(), text: $lastName)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func UserEmailInput() -> some View {
        TextField(UserDefaultsUtils.shared.getUserEmail(), text: $email)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
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
    
    // Airline Prefs
    fileprivate func AirlineInput() -> some View {
        TextField("Airline", text: $airline)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func SeatingClassInput() -> some View {
        TextField("Seating Class", text: $seatingClass)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func SeatTypeInput() -> some View {
        TextField("Seat Type", text: $seatType)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func FlightMealInput() -> some View {
        TextField("Flight Diet", text: $flightMeal)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func FlightSpecialNeedsInput() -> some View {
        TextField("Flight Special Needs/Requests", text: $flightSpecialNeeds)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func FlyerProgramInput() -> some View {
        TextField("Frequent Flyer Program", text: $flightProgram)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func FlyerProgramNameInput() -> some View {
        TextField("Frequent Flyer Program Name", text: $flightProgramName)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
    }
    
    fileprivate func FlyerProgramNumberInput() -> some View {
        TextField("Frequent Flyer Number", text: $flightProgramNumber)
            .font(Font.custom("Poppins-Regular", size: 16))
            .foregroundColor(Color.ColorPrimary)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disabled(true)
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
    
    // Activities Preferences
    
    
}

struct UserPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        UserPreferencesView().environmentObject(FirestoreManager())
    }
}
