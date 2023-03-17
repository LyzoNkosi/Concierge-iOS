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
    
    // MARK: - Properties
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // MARK: - Life Cycle
    init() {
        FirebaseApp.configure()
        
        if(isKeyPresentInUserDefaults(key: "user_logged_in")){
            let _firestoreManager = FirestoreManager()
            
            DispatchQueue.main.async(execute:  {
                _firestoreManager.getAgentClients()
                _firestoreManager.getTickets()
                _firestoreManager.getMyChatMessages()
            })
        }
    }
    
    // MARK: - UI Elements
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(firestoreManager)
        }
    }
}

func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}
