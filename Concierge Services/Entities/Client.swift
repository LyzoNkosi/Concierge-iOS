import Foundation
import RealmSwift

class Client: Object, Identifiable {
    @Persisted var id: String? = ""
    @Persisted var firstName: String? = ""
    @Persisted var lastName: String? = ""
    
    override init() {
        super.init()
    }
    
    init(id: String? = nil, firstName: String? = nil, lastName: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
}
