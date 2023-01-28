//
//  ChatView.swift
//  ChatApp
//
//  Created by Junpei  on 2022/10/27.
//

import SwiftUI

struct ChatView: View {
    
    @State private var messageText = ""
    //@ObservedObject var chatViewModel = ChatViewModel(user: user) userが初期化されていないため引数に指定できない
    @ObservedObject var chatViewModel:ChatViewModel
    let user:User
    
    init(user:User) {
        self.user = user
        self.chatViewModel = ChatViewModel(user: user)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    
                    ForEach(chatViewModel.messages) { message in
                        //MessageView(isCurrentUser: message.isFromCurrentUser, messageText:message.messageText)
                        MessageView(messageViewModel: MessageViewModel(message: message))
                        
                    }
                }
            }
            CustomInputView(messageText: $messageText, sendAction: sendMessage)
        }
        .navigationTitle(user.userName)
        .navigationBarTitleDisplayMode(.inline)
        .padding(.vertical)
    }
    
    func sendMessage() {
        if messageText.isEmpty {
            
        }else{
            chatViewModel.sendMessage(messageText)
            messageText = ""
        }
    }
}

//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView(text: "")
//    }
//}
