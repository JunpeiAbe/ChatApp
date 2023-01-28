//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Junpei  on 2022/10/31.
//

import Firebase
import FirebaseFirestore

class ChatViewModel:ObservableObject {
    
    @Published var messages = [Message]()
    let user:User
    
    init(user:User) {
        //self.messages = mockMessages
        //initでメソッドを呼び出すことでviewModelを定義したところで即呼ばれる
        self.user = user
        fetchMessages()
    }
    
//    var mockMessages:[Message] {
//        [
//            .init(isFromCurrentUser: true, messageText: "mock"),
//            .init(isFromCurrentUser: true, messageText: "mock"),
//            .init(isFromCurrentUser: false, messageText: "mock"),
//            .init(isFromCurrentUser: true, messageText: "mock")
//        ]
//    }
    
    
    
    //送信
    func sendMessage(_ messageText: String){
//        let message = Message(isFromCurrentUser: true, messageText: messageText)
//        messages.append(message)
        guard let fromUserId = AuthViewModel.shared.userSession?.uid else {return}
        guard let toUserId = user.id else {return}
        
        let fromUserRef = COLLECTION_MESSAGES.document(fromUserId).collection(toUserId).document()
        let toUserRef = COLLECTION_MESSAGES.document(toUserId).collection(fromUserId)
        
        let messageId = fromUserRef.documentID //自動生成されるdocumentIDを用いて受信者側にも同じデータを保存する。
        let data: [String:Any] = ["text":messageText,"fromUserId":fromUserId,"toUserId":toUserId,"timestamp":Timestamp(date: Date()),"read":false]
        
        //最近のメッセージ
        let recentCurrentRef = COLLECTION_MESSAGES.document(fromUserId).collection("recent-messages").document(toUserId)
        let recentPartnerRef = COLLECTION_MESSAGES.document(toUserId).collection("recent-messages").document(fromUserId)
        
        fromUserRef.setData(data)
        toUserRef.document(messageId).setData(data)
        recentCurrentRef.setData(data)
        recentPartnerRef.setData(data)
    }
    
    //受信(ここが理解不十分)
    func fetchMessages(){
        guard let fromUserId = AuthViewModel.shared.userSession?.uid else {return}
        guard let toUserId = user.id else {return}
        
        let query = COLLECTION_MESSAGES.document(fromUserId).collection(toUserId).order(by:"timestamp",descending:false)
        
        //addSnapShotListenerを使うとリアルタイムにviewが更新される。
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({$0.type == .added}) else {return}
            
            var messages = changes.compactMap { try? $0.document.data(as: Message.self)}
            
            for (index, message) in messages.enumerated() where message.fromUserId != fromUserId {
                messages[index].user = self.user
            }
            //self.messages = messages
            self.messages.append(contentsOf: messages)
        }
        
        //メッセージを送信した後にすぐに受信できていない
//        query.getDocuments { snapshot, _ in
//
//            guard let documents = snapshot?.documents else {return}
//
//            print(documents)
//            var messages = documents.compactMap { try? $0.data(as: Message.self)}
//            print(self.messages)
//
//            //以下理解できていない
//            for (index, message) in messages.enumerated() where message.fromUserId != fromUserId {
//                messages[index].user = self.user
//            }
//            //self.messages = messages
//            self.messages.append(contentsOf: messages)
//        }
    }
}
