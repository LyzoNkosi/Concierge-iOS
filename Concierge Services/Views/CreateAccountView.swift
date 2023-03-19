import SwiftUI
import AlertToast

struct CreateAccountView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @State private var showToast = false
    @State private var toastMessage = ""
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    var body: some View {
        
        VStack {
            
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
                    
                    firestoreManager.createAuthUser(email: email, password: password, firstName: firstName, lastName: lastName) { newAuthUserCreated in
                        if(newAuthUserCreated) {
                            self.toastMessage = "New user created"
                            self.showToast = true
                            self.presentation.wrappedValue.dismiss()
                        } else {
                            self.toastMessage = "Error creating user"
                            self.showToast = true
                        }
                    }
                    
                }
                .padding(8)
            
        }
        .toast(isPresenting: $showToast) {
            AlertToast(type: .regular, title: toastMessage)
        }
        .padding(12)
        .navigationBarTitle("Add New Member")
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
