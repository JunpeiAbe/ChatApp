//
//  ConversationCellViewModel.swift
//  ChatApp
//
//  Created by Junpei  on 2022/11/01.
//

import SwiftUI

class ConversationCellViewModel: ObservableObject {
    
    @Published var message: Message
    
    init(_ message: Message) {
        self.message = message
        
        fetchChattingUser()
    }
    
    var chatToUserProfileImageUrl: URL?{
        guard let user = message.user else {return nil}
        return URL(string: user.profileImageURL)
    }
    
    var userName: String {
        guard let user = message.user else {return ""}
        return user.userName
    }
    
    
    var chatToUserId: String {
        //メッセージの送信者とログインしているユーザーのアカウントが一致(true)→メッセージ受信者のIDを返す。
        return message.fromUserId == AuthViewModel.shared.userSession?.uid ? message.toUserId : message.fromUserId
    }
    
    func fetchChattingUser() {
        COLLECTION_USER.document(chatToUserId).getDocument { snapshot, _ in
            self.message.user = try? snapshot?.data(as: User.self)
            
        }
    }
    
    //削除
    func deleteMessages(){
        print("deletemessage")
        guard let fromUserId = AuthViewModel.shared.userSession?.uid else {return}
        
        print("fromUserId:",fromUserId,"toUserId:",chatToUserId)
        
        
        let fromUserRef = COLLECTION_MESSAGES.document(fromUserId).collection(chatToUserId)
        let toUserRef = COLLECTION_MESSAGES.document(chatToUserId).collection(fromUserId)
        let recentCurrentRef = COLLECTION_MESSAGES.document(fromUserId).collection("recent-messages").document(chatToUserId)
        let recentPartnerRef = COLLECTION_MESSAGES.document(chatToUserId).collection("recent-messages").document(fromUserId)
        
        fromUserRef.getDocuments { snapshot, error in
            
            if error != nil{
                return
            }
            
            var messageId = []
            if let snapshot = snapshot{
                for document in snapshot.documents {
                    messageId.append(document.documentID)
                    print(messageId)
                }
                
                for i in 0..<messageId.count {
                    print(messageId.count)
                    fromUserRef.document(messageId[i] as! String).delete()
                    toUserRef.document(messageId[i] as! String).delete()
                }
            }
        }
        
        recentCurrentRef.delete()
        recentPartnerRef.delete()
    }
    
    
    
}
