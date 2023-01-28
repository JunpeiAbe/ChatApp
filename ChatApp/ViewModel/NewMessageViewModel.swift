//
//  NewMessageViewModel.swift
//  ChatApp
//
//  Created by Junpei  on 2022/10/30.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        COLLECTION_USER.getDocuments { snapshot, error in
            if error != nil {
                print("UsersData catch error")
                return
            }
            guard let documents = snapshot?.documents else {return}
            //自分以外のuserを取得する
            self.users = documents.compactMap({try? $0.data(as: User.self)}).filter({$0.id != AuthViewModel.shared.userSession?.uid})
            print(self.users)
        }
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercaseQuery = query.lowercased() //小文字への変換
        
        return users.filter({$0.fullName.lowercased().contains(lowercaseQuery) || $0.userName.contains(lowercaseQuery)})
    }
}
