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
    }
    
    // MARK: - UI Elements
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ApplicationSwitcher(firestoreManager: firestoreManager).environmentObject(loginViewModel)
            }
        }
    }
}

struct ApplicationSwitcher: View {
    
    @StateObject var firestoreManager: FirestoreManager
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        
        ZStack {
            if (loginViewModel.isLoggedIn) {
                // TabbarView().environmentObject(firestoreManager).environmentObject(loginViewModel)
                
                
                LoadingUserDataView(firestoreManager: firestoreManager)
                
            } else {
                LoginView().environmentObject(firestoreManager).environmentObject(loginViewModel)
            }
        }
    }
    
    private func isUserAdmin() -> Bool {
        if(UserDefaultsUtils.shared.isUserAdmin()) {
            return true
        }
        return false
    }
}
