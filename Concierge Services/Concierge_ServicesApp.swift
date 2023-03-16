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
        
        firestoreManager.getAgentClients()
    }
    
    // MARK: - UI Elements
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(firestoreManager)
        }
    }
}
