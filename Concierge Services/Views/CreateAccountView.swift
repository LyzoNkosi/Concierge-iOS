import SwiftUI
import AlertToast
import ActivityIndicatorView

struct CreateAccountView: View {
    
    let primaryBlack = Color(red: 31.0/255.0, green: 34.0/255.0, blue: 41.0/255.0, opacity: 1.0)
    
    @Environment(\.presentationMode) var createAccountPresentation
    
    @State private var showToast = false
    @State private var toastMessage = ""
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @State private var showLoadingIndicator: Bool = false
    
    var body: some View {
        
        VStack {
            
            ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .default())
                .frame(width: 64, height: 64)
                .foregroundColor(primaryBlack)
            
            CreateAccountLabelText()
            
            ScrollView {
                
                FirstNameInput()
                LastNameInput()
                EmailInput()
                PasswordInput()
                
            }
            
        }
        .padding()
        .safeAreaInset(edge: .bottom) {
            
            CreateAccountButtonContent()
                .onTapGesture {
                    
                    if(!showLoadingIndicator) {
                        
                        if(self.firstName.isEmpty) {
                            self.toastMessage = "Please enter first name"
                            self.showToast = true
                            return
                        }
                        
                        if(self.lastName.isEmpty) {
                            self.toastMessage = "Please enter last name"
                            self.showToast = true
                            return
                        }
                        
                        if(self.email.isEmpty) {
                            self.toastMessage = "Please enter email"
                            self.showToast = true
                            return
                        }
                        
                        if(self.email.count < 5 || !self.email.contains("@") || !self.email.contains(".")) {
                            self.toastMessage = "Please enter valid email"
                            self.showToast = true
                            return
                        }
                        
                        if(self.password.isEmpty) {
                            self.toastMessage = "Please enter password"
                            self.showToast = true
                            return
                        }
                        
                        if(self.password.count < 8) {
                            self.toastMessage = "Password must be at least 8 characters"
                            self.showToast = true
                            return
                        }
                        
                        self.showLoadingIndicator = true
                        
                        firestoreManager.createAuthUser(email: email, password: password, firstName: firstName, lastName: lastName) { newAuthUserCreated in
                            
                            if(newAuthUserCreated) {
                                self.toastMessage = "New user created"
                                self.showToast = true
                                self.showLoadingIndicator = false
                                
                                self.createAccountPresentation.wrappedValue.dismiss()
                            } else {
                                self.toastMessage = "Error creating user"
                                self.showToast = true
                                
                                self.showLoadingIndicator = false
                            }
                        }
                    } else {
                        self.toastMessage = "Account creation in progress"
                        self.showToast = true
                    }
                }
                .padding(8)
            
        }
        .toast(isPresenting: $showToast) {
            AlertToast(type: .regular, title: toastMessage,
                       style: AlertToast.AlertStyle.style(backgroundColor: Color.ColorPrimary, titleColor: Color.TextColorPrimary, subTitleColor: Color.TextColorPrimary, titleFont: Font.custom("Poppins-Regular", size: 12), subTitleFont: Font.custom("Poppins-Light", size: 12)))
        }
        .padding(12)
        .navigationBarTitle("Add New Member")
    }
    
    fileprivate func FirstNameInput() -> some View {
        TextField("First Name", text: $firstName)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disableAutocorrection(true)
            .padding(.bottom, 20)
    }
    
    fileprivate func LastNameInput() -> some View {
        TextField("Last Name", text: $lastName)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .disableAutocorrection(true)
            .padding(.bottom, 20)
    }
    
    fileprivate func EmailInput() -> some View {
        TextField("Email", text: $email)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .keyboardType(.emailAddress)
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
    
    
    fileprivate func PasswordInput() -> some View {
        SecureField("Password", text: $password)
            .padding()
            .background(Color.LightGreyColor)
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
            .background(Color.ColorPrimary)
            .cornerRadius(15.0)
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
