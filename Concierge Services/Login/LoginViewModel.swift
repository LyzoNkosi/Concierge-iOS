import Foundation
import FirebaseAuth


struct AuthUser {
    let uid: String
    let email: String
}

class LoginViewModel: ObservableObject{
    
    @Published var email = "user@email.com"
    @Published var password = "1234567"
    @Published private var _currentAuthUser : AuthUser? = nil
    @Published var hasError = false
    @Published var errorMessage = ""
    @Published var isLoggedIn = false
    
    private var handler = Auth.auth().addStateDidChangeListener{_,_ in }
    
    var currentAuthUser: AuthUser {
        return _currentAuthUser ?? AuthUser(uid: "", email: "")
    }
    
    init(){
        handler = Auth.auth().addStateDidChangeListener{ auth, authUser in
            if let authUser = authUser {
                self._currentAuthUser = AuthUser(uid: authUser.uid, email: authUser.email!)
                self.isLoggedIn = true
            } else {
                self._currentAuthUser = nil
                self.isLoggedIn = false
            }
        }
    }
    
    func signIn() async {
        hasError = false
        do{
            try await Auth.auth().signIn(withEmail: email, password: password)
        }catch{
            hasError = true
            errorMessage = error.localizedDescription
        }
    }
    
    func signOut() async {
        hasError = false
        do{
            try Auth.auth().signOut()
            
        }catch{
            hasError = true
            errorMessage = error.localizedDescription
        }
        
    }
    
    deinit{
        Auth.auth().removeStateDidChangeListener(handler)
    }
}
