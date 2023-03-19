import SwiftUI

class UserSettings: ObservableObject {
    @Published var loggedIn : Bool = false
    @Published var navigateNowToLogIn: Bool = false
    @Published var navigateNowToSignup: Bool = false
}
let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
let primaryBlack = Color(red: 31.0/255.0, green: 34.0/255.0, blue: 41.0/255.0, opacity: 1.0)

struct LoginView : View {
    
    @State var email: String = ""
    //@State var password: String = ""
    
    @State var isPresented = false
    
    @State private var showingForgotPasswordAlert = false
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @ObservedObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            if(loginViewModel.isLoggedIn) {
                //TabbarView().environmentObject(firestoreManager)
            } else {
                
                WelcomeText()
                
                UserImage()
                
                /*fileprivate func EmailInput() -> some View {
                 TextField("Email", text: $email)
                 .padding()
                 .background(lightGreyColor)
                 .cornerRadius(5.0)
                 .padding(.bottom, 20)
                 .keyboardType(.emailAddress)
                 .disableAutocorrection(true)
                 .autocapitalization(.none)
                 }*/
                
                /*SecureField("Password", text: $password)
                 .padding()
                 .background(lightGreyColor)
                 .cornerRadius(5.0)
                 .padding(.bottom, 20)*/
                
                EmailInput()
                PasswordInput()
                
                ForgotPasswordText().onTapGesture(perform: {
                    showingForgotPasswordAlert = true
                }).alert("Forgot Password?", isPresented: $showingForgotPasswordAlert, actions: {
                    // Any view other than Button would be ignored
                    TextField("TextField", text: $email)
                        .background(lightGreyColor)
                }, message: {
                    // Any view other than Text would be ignored
                    TextField("Forgot Password", text: .constant("Enter your email"))
                })
                
                //LoginButtonContent()
                
                Button(action: {
                    Task {
                        await loginViewModel.signIn(firestoreManager: firestoreManager)
                    }
                }) {
                    LoginButtonContent()
                }
                
                OrText()
                
                AppleLogo()
            }
        }
        .alert("Error", isPresented: $loginViewModel.hasError) {
        } message: {
            Text(loginViewModel.errorMessage)
        }
        .padding()
        
    }
    
    fileprivate func EmailInput() -> some View {
        TextField("Email", text: $loginViewModel.email)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .keyboardType(.emailAddress)
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
    
    
    fileprivate func PasswordInput() -> some View {
        SecureField("Password", text: $loginViewModel.password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
    
    fileprivate func LoginButton() -> some View {
        Button(action: {
            Task {
                await loginViewModel.signIn(firestoreManager: firestoreManager)
            }
        }) {
            LoginButtonContent()
        }
    }
    
}

#if DEBUG
struct LoginView_Previews : PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif

struct WelcomeText : View {
    var body: some View {
        return Text("Savante")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct UserImage : View {
    var body: some View {
        return Image("tuxedo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(48)
            .padding(.bottom, 75)
    }
}

struct ForgotPasswordText : View {
    var body: some View {
        return Text("Forgot Password?")
            .font(.body)
            .fontWeight(.semibold)
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct LoginButtonContent : View {
    var body: some View {
        return Text("Login")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(primaryBlack)
            .cornerRadius(15.0)
    }
}

struct OrText : View {
    var body: some View {
        return Text("OR")
            .font(.body)
            .fontWeight(.semibold)
            .padding(16)
    }
}

struct AppleLogo : View {
    var body: some View {
        return Image("apple_logo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 42, height: 42)
            .padding(16)
    }
}
