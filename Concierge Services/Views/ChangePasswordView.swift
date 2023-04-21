//
//  ChangePasswordView.swift
//  Concierge Services
//
//  Created by Slindelo Mathenjwa on 2023/03/28.
//
import SwiftUI
import AlertToast

struct ChangePasswordView: View {
    @State var oldPassword: String = ""
    @State var newPassword: String = ""
    @State var confirmPassword: String = ""
    
    @State private var showToast = false
    @State private var toastMessage = ""
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @Environment(\.presentationMode) private var presantationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            
            TextField( "Enter Old Password", text: self.$oldPassword)
                .padding()
                .background(Color.LightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            TextField( "Enter New Password", text: self.$newPassword)
                .padding()
                .background(Color.LightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            TextField( "Confirm New Password", text: self.$confirmPassword)
                .padding()
                .background(Color.LightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            Spacer()
            
            Button(action: {
                if(self.oldPassword.isEmpty) {
                    self.toastMessage = "Old password field cannot be empty"
                    self.showToast = true
                    return
                }
                
                if( self.newPassword.isEmpty) {
                    self.toastMessage = "New password field cannot be empty"
                    self.showToast = true
                    return
                }
                
                if(self.newPassword != self.confirmPassword){
                    self.toastMessage = "The passwords you've entered don't match!"
                    self.showToast = true
                    return
                    
                }
                
                firestoreManager.changePassword(email: UserDefaultsUtils().getUserEmail() ,password: oldPassword, newPassword: newPassword){ passwordChanged in
                    
                    if(passwordChanged) {
                        self.toastMessage = "Password Changed"
                        self.showToast = true
                        
                        presantationMode.wrappedValue.dismiss()
                        
                    } else {
                        self.toastMessage = "Error creating new password"
                        self.showToast = true
                    }
                    
                }
                
            }, label: {
                Text("Save Details")
                    .font(Font.custom("Poppins-Medium", size: 18))
                    .foregroundColor(Color.TextColorPrimary)
                    .frame(width: 220, height: 60)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.ColorPrimary, Color.ColorSecondary]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(15.0)
                    .padding()
            })
            
            
        }
        .toast(isPresenting: $showToast) {
            AlertToast(type: .regular, title: toastMessage,
                       style: AlertToast.AlertStyle.style(backgroundColor: Color.ColorPrimary, titleColor: Color.TextColorPrimary, subTitleColor: Color.TextColorPrimary, titleFont: Font.custom("Poppins-Regular", size: 12), subTitleFont: Font.custom("Poppins-Light", size: 12)))
        }
        .padding()
        .navigationTitle("Change Password")
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
