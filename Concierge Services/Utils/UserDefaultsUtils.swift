import Foundation

class UserDefaultsUtils {
    
    static var shared = UserDefaultsUtils()
    
    func clearAllValues() {
        let domain = Bundle.main.bundleIdentifier!
        let defaults = UserDefaults.standard
        defaults.removePersistentDomain(forName: domain)
    }
    
    func setDarkMode(enable: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(enable, forKey: Constants.DARK_MODE)
        defaults.synchronize()
    }
    
    func getDarkMode() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: Constants.DARK_MODE)
    }
    
    func setUserLoggedIn(enable: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(enable, forKey: "user_logged_in")
        defaults.synchronize()
    }
    
    func getUserLoggedIn() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "user_logged_in")
    }
    
    func setUserId(uid: String) {
        let defaults = UserDefaults.standard
        defaults.set(uid, forKey: "firebase_uid")
        defaults.synchronize()
    }
    
    func getUserId() -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "firebase_uid") ?? ""
    }
    
    func setUserEmail(value: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: "user_email")
        defaults.synchronize()
    }
    
    func getUserEmail() -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "user_email") ?? ""
    }
    
    func setUserFirstName(value: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: "first_name")
        defaults.synchronize()
    }
    
    func getUserFirstName() -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "first_name") ?? ""
    }
    
    func setUserLastName(value: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: "last_name")
        defaults.synchronize()
    }
    
    func getUserLastName() -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "last_name") ?? ""
    }
    
    func setUserRole(value: Int) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: "user_role")
        defaults.synchronize()
    }
    
    func getUserRole() -> Int {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: "user_role")
    }
    
    func isUserAdmin() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: "user_role") >= 2
    }
    
}
