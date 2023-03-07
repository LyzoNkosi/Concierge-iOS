import Foundation

struct Message: Hashable {
    var content: String
    var user: User
}

struct DataSource {
    static let firstUser = User(name: "Mbali", avatar: "profile")
    static var secondUser = User(name: "Cool Client", avatar: "profile", isCurrentUser: true)
    static let messages = [
        Message(content: "Hi, I need a trip to Vegas.", user: DataSource.firstUser),
        Message(content: "How many people will you be travelling with?", user: DataSource.secondUser),
        Message(content: "Just me. I need a break from the world.", user: DataSource.firstUser),
        Message(content: "I have made the arrangements for you.", user: DataSource.firstUser),
        Message(content: "Great, let me check...", user: DataSource.secondUser),
        Message(content: "Cool cool.", user: DataSource.firstUser)
    ]
}
