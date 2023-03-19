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
    
    // private var handler = Auth.auth().addStateDidChangeListener {_,_ in }
    
    var currentAuthUser: AuthUser {
        return _currentAuthUser ?? AuthUser(uid: "", email: "")
    }
    
    /*init() {
     handler = Auth.auth().addStateDidChangeListener { auth, authUser in
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
     }*/
    
    init() {
        if(isUserLoggedIn()) {
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
                    self.hasError = true
                }
                
                let authUser = authResult?.user
                // Signed in
                self._currentAuthUser = AuthUser(uid: authUser!.uid, email: authUser!.email!)
                self.isLoggedIn = true
                
                self.defaults.set(authUser!.uid, forKey: "firebase_uid")
                self.defaults.set(authUser!.email, forKey: "user_email")
                self.defaults.set(true, forKey: "user_logged_in")
                self.defaults.synchronize()
                
                self.firestoreManager?.fetchUserDetails(userID: authUser!.uid)
                
                //DispatchQueue.main.sync(execute:  {
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
            
            self.defaults.removePersistentDomain(forName: domain)
            
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
    
    private func isUserLoggedIn () -> Bool {
        if(isKeyPresentInUserDefaults(key: "user_logged_in")) {
            if(UserDefaults.standard.object(forKey: "user_logged_in") as! Bool) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
