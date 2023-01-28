//
//  User.swift
//  ChatApp
//
//  Created by Junpei  on 2022/10/29.
//

import SwiftUI
import FirebaseFirestoreSwift

struct User:Decodable,Identifiable{
    @DocumentID var id: String?
    let userName:String
    let fullName:String
    let email:String
    let profileImageURL: String
    
}

//let MOCK_USER = User(id: "123456", userName: "Test", fullName: "Test", email: "test@gmail.com", profileImageURL: "www.google.com")
