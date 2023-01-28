//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by Junpei  on 2022/11/01.
//

import Foundation

struct MessageViewModel {
    
    let message:Message
    
    var currentUid: String {
        return AuthViewModel.shared.userSession?.uid ?? ""
    }
    
    var isFromCurrentUser:Bool {
        return message.fromUserId == currentUid
    }
    
    var profileImageUrl: URL? {
        //デフォルトを返したくない場合はguard letでnilを返す
        return URL(string: message.user?.profileImageURL ?? "")
    }
}
