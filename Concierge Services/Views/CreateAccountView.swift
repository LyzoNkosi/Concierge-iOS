//
//  CreateAccountView.swift
//  Concierge Services
//
//  Created by Mac on 2023/03/14.
//

import SwiftUI

struct CreateAccountView: View {
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                CreateAccountLabelText()
                
                FirstNameInput()
                LastNameInput()
                EmailInput()
                PasswordInput()
                
            }
            .padding()
            
            Spacer()
            
            .safeAreaInset(edge: .bottom) {
                CreateAccountButtonContent()
            } .padding(12)
        }
        .navigationTitle("Add New Member")
    }
    
    fileprivate func FirstNameInput() -> some View {
        TextField("First Name", text: $firstName)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
    
    fileprivate func LastNameInput() -> some View {
        TextField("Last Name", text: $lastName)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
    
    fileprivate func EmailInput() -> some View {
        TextField("Email", text: $email)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .keyboardType(.emailAddress)
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
    
    
    fileprivate func PasswordInput() -> some View {
        SecureField("Password", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct CreateAccountLabelText : View {
    var body: some View {
        return Text("Create Account")
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct CreateAccountButtonContent : View {
        var body: some View {
            return Text("Create Account")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(primaryBlack)
                .cornerRadius(15.0)
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
