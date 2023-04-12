import SwiftUI


struct UserProfileView: View {
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @State var userFullName: String = ""
    @State var email: String = ""
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading, spacing: 24) {
                ProfileImage()
                    .padding(24)
            }
            
            UserNameInput()
            
            UserEmailInput()
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .navigationTitle("Profile")
    }
    
    fileprivate func GetUserDetails() -> String
    {
        let firstName = UserDefaultsUtils.shared.getUserFirstName()
        let lastName = UserDefaultsUtils.shared.getUserLastName()
        return firstName + " " + lastName
    }
    
    fileprivate func UserNameInput() -> some View {
        TextField(GetUserDetails(), text: $userFullName)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .padding()
            .disabled(true)
    }
    
    fileprivate func UserEmailInput() -> some View {
        TextField(UserDefaultsUtils.shared.getUserEmail(), text: $email)
            .padding()
            .background(Color.LightGreyColor)
            .cornerRadius(5.0)
            .padding()
            .disabled(true)
    }
}

struct ProfileImage : View {
    
    var body: some View {
        return Image(systemName: "person.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .clipped()
            .padding(.bottom, 75)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
