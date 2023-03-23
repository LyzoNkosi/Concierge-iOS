import Foundation
import FirebaseAuth
import RealmSwift

struct AuthUser {
    let uid: String
    let email: String
}

@MainActor
class LoginViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    @Published private var _currentAuthUser : AuthUser? = nil
    @Published var hasError = false
    @Published var errorMessage = ""
    @Published var isLoggedIn = false
    
    var firestoreManager: FirestoreManager? = nil
    
    var currentAuthUser: AuthUser {
        return _currentAuthUser ?? AuthUser(uid: "", email: "")
    }
    
    init() {
        if(UserDefaultsUtils.shared.getUserLoggedIn()) {
            self.isLoggedIn = true
        } else {
            self.isLoggedIn = false
        }
    }
    
    func signIn(firestoreManager: FirestoreManager) async {
        self.firestoreManager = firestoreManager
        
        hasError = false
        do {
            // try await Auth.auth().signIn(withEmail: email, password: password)
            
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if (error != nil) {
                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                    // you're sending the SHA256-hashed nonce as a hex string with
                    // your request to Apple.
                    print(error?.localizedDescription as Any)
                    self.errorMessage = error?.localizedDescription as? String ?? "Error logging in, please try again"
                    self.hasError = true
                    return
                }
                
                if(authResult?.user == nil) {
                    self.errorMessage = error?.localizedDescription as? String ?? "Error logging in, please try again"
                    self.hasError = true
                    return
                }
                
                let authUser = authResult?.user
                // Signed in
                self._currentAuthUser = AuthUser(uid: authUser!.uid, email: authUser!.email!)
                self.isLoggedIn = true
                
                UserDefaultsUtils.shared.setUserId(uid: authUser!.uid)
                UserDefaultsUtils.shared.setUserEmail(value: authUser!.email ?? "")
                UserDefaultsUtils.shared.setUserLoggedIn(enable: true)
                
                self.firestoreManager?.fetchUserDetails(userID: authUser!.uid)
                
                firestoreManager.getAgentClients() { clientsSynced in
                    if(clientsSynced) {
                        print("Clients synced")
                    } else {
                        print("Clients sync error")
                    }
                }
                
                firestoreManager.getTickets()
                firestoreManager.getMyChatMessages()
                
                self.isLoggedIn = true
                
            }
            
        } catch {
            hasError = true
            errorMessage = error.localizedDescription
        }
    }
    
    func signOut() async {
        hasError = false
        do {
            try Auth.auth().signOut()
            
            UserDefaultsUtils.shared.clearAllValues()
            
            do{
                let realm = try await Realm()
                
                DispatchQueue.main.async(execute:  {
                    try! realm.write{
                        realm.deleteAll()
                    }
                })
            } catch let realmError as NSError{
                print("error - \(realmError.localizedDescription)")
            }
            
        } catch {
            hasError = true
            errorMessage = error.localizedDescription
        }
        self.isLoggedIn = false
    }
}
