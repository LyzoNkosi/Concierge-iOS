import SwiftUI

struct ContentMessageView: View {
    var contentMessage: String
    var messageType: Int
    
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(messageType == MessageType.TYPE_SENT.rawValue ? Color.white : Color.black)
            .background(messageType == MessageType.TYPE_SENT.rawValue  ? Color.blue : Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
            .cornerRadius(10)
    }
}

struct ContentMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentMessageView(contentMessage: "Hi, I how may I help you?", messageType: MessageType.TYPE_SENT.rawValue)
    }
}
