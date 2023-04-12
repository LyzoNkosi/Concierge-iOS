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

    
    
    
    var body: some View {
        VStack{
            
            Text("Change Password")
                .font(.system(size: 20, weight: .semibold, design: .monospaced))
                .padding(80)
            
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
                if(self.oldPassword.isEmpty ) {
                    self.toastMessage = "This field cannot be empty"
                    self.showToast = true
                    return
                           }
                if( self.newPassword.isEmpty ) {
                    self.toastMessage = "This field cannot be empty"
                    self.showToast = true
                    return
                           }
                if(self.confirmPassword.isEmpty ) {
                    self.toastMessage = "This field cannot be empty"
                    self.showToast = true
                    return
                           }
                
                if(self.newPassword != self.confirmPassword){
                    self.toastMessage = "The Passwords you've entered do not match!"
                    self.showToast = true
                    return
                    
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
        .padding()
    }
    
    struct ChangePasswordView_Previews: PreviewProvider {
        static var previews: some View {
            ChangePasswordView()
        }
    }
}
