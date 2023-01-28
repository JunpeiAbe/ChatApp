//
//  NewMessageView.swift
//  ChatApp
//
//  Created by Junpei  on 2022/10/27.
//

import SwiftUI

struct NewMessageView: View {
    
    //登録ユーザのデータをキャッチ→選択→画面を閉じる→ConverSationに表示(個別の部屋を作る)→Chatを開く
    
    @State private var searchText = ""
    @ObservedObject var newMessageViewModel = NewMessageViewModel()
    @Environment (\.dismiss) var dismiss
    @Binding var user: User?
    @Binding var showChatView: Bool
    
    var body: some View {
        VStack{
            SearchBar(text: $searchText)
                .padding(.top,20)
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(searchText.isEmpty ? newMessageViewModel.users : newMessageViewModel.filteredUsers(searchText)){ user in
                        Button(action: {
                            dismiss() //画面を閉じる
                            self.user = user //ユーザーの情報をConversationに渡す
                            showChatView.toggle()
                        }) {
                            UserCell(user: user)
                        }
                    }
                }
            }
        }
    }
}


