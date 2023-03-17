import SwiftUI

struct ClientMessageView : View {
    var currentMessage: ChatMessage
    var body: some View {
        HStack(alignment: .bottom, spacing: 15) {
            if currentMessage.messageType != MessageType.TYPE_RECEIVED.rawValue {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
            } else {
                Spacer()
            }
            ContentMessageView(contentMessage: currentMessage.message!,
                               messageType: currentMessage.messageType)
        }.padding()
    }
}

struct ClientMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ClientMessageView(currentMessage: ChatMessage(id: "123654", messageType: MessageType.TYPE_SENT.rawValue, message: "Lorem Ipsum", dateTime: "12-3-2023 14:03"))
    }
}
