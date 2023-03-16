import Firebase
import FirebaseFirestore

class FirestoreManager: ObservableObject{
    
    @Published var someStr: String = ""
    
    func fetchUserDetails(userID: String) {
        let database = Firestore.firestore()
        let defaults = UserDefaults.standard

        let userRef = database.collection("users").document(userID)

        userRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }

            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    defaults.set(data["first_name"] as? String ?? "", forKey: "first_name")
                    defaults.set(data["last_name"] as? String ?? "", forKey: "last_name")
                    
                    defaults.synchronize()
                }
            }

        }
    }
    
}
