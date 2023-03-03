import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
let primaryBlack = Color(red: 31.0/255.0, green: 34.0/255.0, blue: 41.0/255.0, opacity: 1.0)

struct ContentView : View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        
        VStack {
            WelcomeText()
            UserImage()
            TextField("Email", text: $email)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Password", text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            ForgotPasswordText()
            Button(action: {print("Button tapped")}) {
               LoginButtonContent()
            }
            OrText()
            AppleLogo()
        }
        .padding()
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
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
