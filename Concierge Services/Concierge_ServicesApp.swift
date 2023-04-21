import SwiftUI
import FirebaseCore
import RealmSwift

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // MARK: - Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
@main
struct Concierge_ServicesApp: SwiftUI.App {
    
    @StateObject var firestoreManager = FirestoreManager()
    @StateObject var loginViewModel = LoginViewModel()
    
    // MARK: - Properties
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // MARK: - Life Cycle
    init() {
        FirebaseApp.configure()
        
        initRealm()
    }
    
    private func initRealm() {
        let config = Realm.Configuration(
            schemaVersion: 3,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 3) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })
        Realm.Configuration.defaultConfiguration = config
        _ = try! Realm()
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
                LoadingUserDataView(firestoreManager: firestoreManager).environmentObject(loginViewModel)
            } else {
                LoginView().environmentObject(firestoreManager).environmentObject(loginViewModel)
            }
        }
    }
}
