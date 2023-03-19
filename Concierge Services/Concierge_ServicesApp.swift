import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // MARK: - Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
@main
struct Concierge_ServicesApp: App {
    
    @StateObject var firestoreManager = FirestoreManager()
    @StateObject var loginViewModel = LoginViewModel()
    
    // MARK: - Properties
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // MARK: - Life Cycle
    init() {
        FirebaseApp.configure()
        
        /*if(isLoggedIn()) {
         let _firestoreManager = FirestoreManager()
         
         DispatchQueue.main.async(execute:  {
         _firestoreManager.getAgentClients() { clientsSynced in
         if(clientsSynced) {
         print("Clients synced")
         } else {
         print("Clients sync error")
         }
         }
         
         _firestoreManager.getTickets()
         _firestoreManager.getMyChatMessages()
         })
         }*/
    }
    
    // MARK: - UI Elements
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ApplicationSwitcher(firestoreManager: firestoreManager).environmentObject(loginViewModel)
            }
            /*if(isLoggedIn()) {
             TabbarView().environmentObject(firestoreManager)
             } else {
             LoginView().environmentObject(firestoreManager)
             }*/
        }
    }
    
    /*private func isLoggedIn () -> Bool {
     if(isKeyPresentInUserDefaults(key: "user_logged_in")) {
     if(UserDefaults.standard.object(forKey: "user_logged_in") as! Bool) {
     return true
     } else {
     return false
     }
     } else {
     return false
     }
     }*/
}

struct ApplicationSwitcher: View {
    
    @StateObject var firestoreManager: FirestoreManager
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        if (loginViewModel.isLoggedIn) {
            TabbarView().environmentObject(firestoreManager).environmentObject(loginViewModel)
        } else {
            LoginView().environmentObject(firestoreManager).environmentObject(loginViewModel)
        }
        
    }
}

func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}
