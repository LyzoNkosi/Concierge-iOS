import Foundation
import FirebaseAuth
import RealmSwift

struct AuthUser {
    let uid: String
    let email: String
}

class LoginViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    @Published private var _currentAuthUser : AuthUser? = nil
    @Published var hasError = false
    @Published var errorMessage = ""
    @Published var isLoggedIn = false
    
    let domain = Bundle.main.bundleIdentifier!
    let defaults = UserDefaults.standard
    
    var firestoreManager: FirestoreManager? = nil
    
    private var handler = Auth.auth().addStateDidChangeListener{_,_ in }
    
    var currentAuthUser: AuthUser {
        return _currentAuthUser ?? AuthUser(uid: "", email: "")
    }
    
    init(){
        handler = Auth.auth().addStateDidChangeListener{ auth, authUser in
            if let authUser = authUser {
                self._currentAuthUser = AuthUser(uid: authUser.uid, email: authUser.email!)
                self.isLoggedIn = true
                
                self.defaults.set(authUser.uid, forKey: "firebase_uid")
                self.defaults.set(authUser.email, forKey: "user_email")
                self.defaults.set(true, forKey: "user_logged_in")
                self.defaults.synchronize()
                
                self.firestoreManager?.fetchUserDetails(userID: authUser.uid)
                
            } else {
                self._currentAuthUser = nil
                self.isLoggedIn = false
            }
        }
    }
    
    func signIn(firestoreManager: FirestoreManager) async {
        self.firestoreManager = firestoreManager
        
        hasError = false
        do{
            try await Auth.auth().signIn(withEmail: email, password: password)
            
            firestoreManager.getAgentClients()
            firestoreManager.getTickets()
            firestoreManager.getMyChatMessages()
            
        }catch{
            hasError = true
            errorMessage = error.localizedDescription
        }
    }
    
    func signOut() async {
        hasError = false
        do{
            try Auth.auth().signOut()
            
            self.defaults.removePersistentDomain(forName: domain)
            
            do{
                let realm = try await Realm()
                
                try! realm.write{
                    realm.deleteAll()
                }
            } catch let realmError as NSError{
                print("error - \(realmError.localizedDescription)")
            }
            
        }catch{
            hasError = true
            errorMessage = error.localizedDescription
        }
        
    }
    
    deinit{
        Auth.auth().removeStateDidChangeListener(handler)
    }
}
