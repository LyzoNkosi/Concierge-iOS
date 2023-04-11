import SwiftUI
import AlertToast

class UserSettings: ObservableObject {
    @Published var loggedIn : Bool = false
    @Published var navigateNowToLogIn: Bool = false
    @Published var navigateNowToSignup: Bool = false
}

struct LoginView : View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @State private var isDarkModeOn = false
    
    @State var email: String = ""
    //@State var password: String = ""
    
    @State var isPresented = false
    
    @State private var showingForgotPasswordAlert = false
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @State private var showToast = false
    @State private var toastMessage = ""
    
    func setAppTheme() {
        //MARK: use saved device theme from toggle
        isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()
        //MARK: or use device theme
        
        if (colorScheme == .dark)
        {
            isDarkModeOn = true
        }
        else {
            isDarkModeOn = false
        }
        
        //changeDarkMode(state: isDarkModeOn)
    }
    
    func changeDarkMode(state: Bool) {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ? .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
    
    var body: some View {
        ScrollView {
            if(loginViewModel.isLoggedIn) {
                //TabbarView().environmentObject(firestoreManager)
            } else {
                
                // WelcomeText()
                
                UserImage()
                
                EmailInput()
                PasswordInput()
                
                ForgotPasswordText().onTapGesture(perform: {
                    showingForgotPasswordAlert = true
                }).alert("Forgot Password?", isPresented: $showingForgotPasswordAlert, actions: {
                    // Any view other than Button would be ignored
                    TextField("TextField", text: $email)
                        .background(Color.LightGreyColor)
                }, message: {
                    // Any view other than Text would be ignored
                    TextField("Forgot Password", text: .constant("Enter your email"))
                })
                
                //LoginButtonContent()
                
                Button(action: {
                    Task {
                        if(loginViewModel.email.isEmpty) {
                            self.toastMessage = "Please enter email address"
                            self.showToast = true
                            return
                        }
                        
                        if(loginViewModel.password.isEmpty) {
                            self.toastMessage = "Please enter password"
                            self.showToast = true
                            return
                        }
                        
                        if(loginViewModel.email.count < 5 || !loginViewModel.email.contains("@") || !loginViewModel.email.contains(".")) {
                            self.toastMessage = "Please enter valid email"
                            self.showToast = true
                            return
                        }
                        
                        await loginViewModel.signIn(firestoreManager: firestoreManager)
                    }
                }) {
                    LoginButtonContent()
                }
                
                // OrText()
                
                // AppleLogo()
            }
        }
        .background(Color.BackgroundColorList)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            setAppTheme()
        })
        .alert("Error", isPresented: $loginViewModel.hasError) {
        } message: {
            Text(loginViewModel.errorMessage)
                .font(Font.custom("Poppins-Light", size: 12))
                .foregroundColor(Color.TextColorPrimary)
        }
        .toast(isPresenting: $showToast) {
            AlertToast(type: .regular, title: toastMessage,
                       style: AlertToast.AlertStyle.style(backgroundColor: Color.ColorPrimary, titleColor: Color.TextColorPrimary, subTitleColor: Color.TextColorPrimary, titleFont: Font.custom("Poppins-Regular", size: 12), subTitleFont: Font.custom("Poppins-Light", size: 12)))
        }
        .padding()
        
    }
    
    fileprivate func EmailInput() -> some View {
        TextField("Email", text: $loginViewModel.email)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .keyboardType(.emailAddress)
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
    
    
    fileprivate func PasswordInput() -> some View {
        SecureField("Password", text: $loginViewModel.password)
            .padding()
            .background(Color.LightGreyColor)
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

struct LoginView_Previews : PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct WelcomeText : View {
    var body: some View {
        return Text("African Sun")
            .font(Font.custom("Poppins-Bold", size: 46))
            .foregroundColor(Color.ColorPrimary)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct UserImage : View {
    var body: some View {
        return Image("african_sun_logo_no_bg")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 256, height: 256)
            .clipped()
            .padding(.bottom, 75)
    }
}

struct ForgotPasswordText : View {
    var body: some View {
        return Text("Forgot Password?")
            .font(Font.custom("Poppins-Bold", size: 18))
            .foregroundColor(Color.ColorPrimary)
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct LoginButtonContent : View {
    var body: some View {
        return Text("Login")
            .font(Font.custom("Poppins-Medium", size: 18))
            .foregroundColor(Color.TextColorPrimary)
            .padding()
            .frame(width: 220, height: 60)
            .background(LinearGradient(gradient: Gradient(colors: [Color.ColorPrimary, Color.ColorSecondary]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(15.0)
    }
}

struct OrText : View {
    var body: some View {
        return Text("OR")
            .font(Font.custom("Poppins-Bold", size: 14))
            .foregroundColor(Color.ColorPrimary)
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
