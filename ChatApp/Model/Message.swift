//
//  Message.swift
//  ChatApp
//
//  Created by Junpei  on 2022/10/31.
//

import Firebase
import SwiftUI
import FirebaseFirestoreSwift

struct Message: Identifiable, Decodable{
    @DocumentID var id: String?
    let fromUserId: String //送信者側のID
    let toUserId: String //受信者側のID
    let read: Bool
    let text: String //テキスト
    let timestamp: Timestamp //送信時間
    var user: User? //ユーザー情報

}

//struct Message: Identifiable{
//    let  id =  NSUUID().uuidString
//    let isFromCurrentUser: Bool
//    let messageText:String
//    
//}
