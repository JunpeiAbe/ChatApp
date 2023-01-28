//
//  ConversationView.swift
//  ChatApp
//
//  Created by Junpei  on 2022/10/27.
//

import SwiftUI

struct ConversationView: View {
    
    @State private var showNewMessageView = false
    @State private var showChatView = false
    @State var selectedUser:User?
    @ObservedObject var conversationViewModel = ConversationViewModel()
    
    @EnvironmentObject var authViewModel:AuthViewModel
    
    var body: some View {
        
        if let userName = authViewModel.currentUser?.userName {
            NavigationView {
                ZStack {
                    //NewMessageViewでユーザー選択したあとの処理(チャット画面への遷移)
                    if let user = selectedUser {
                        NavigationLink(destination: ChatView(user: user), isActive: $showChatView, label: {})
                    }
                    
                    if conversationViewModel.recentMessages.isEmpty {
                        VStack {
                            Image(systemName:"message.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width:180, height: 180)
                                .foregroundColor(Color(.systemGray5))
                            Text("チャットしているユーザーはいません")
                                .font(.system(size: 20,weight: .bold))
                                .foregroundColor(Color(.systemGray4))
                        }
                    }else{
                        List{
                            ForEach(conversationViewModel.recentMessages) { message in
                                ConversationCell(conversationCellViewModel: ConversationCellViewModel(message))
                                    .swipeActions(edge:.trailing) {
                                        Button(role: .destructive) {
                                            withAnimation(.linear(duration: 0.4)){
                                                print("withanimation")
                                                ConversationCellViewModel(message).deleteMessages()
                                            }
                                            
                                        } label: {
                                            Label("削除",systemImage: "trash")
                                        }
                                    }
                            }
                            .onDelete { IndexSet in
                                conversationViewModel.recentMessages.remove(at: IndexSet.first!)}
                        }.listStyle(.plain)
                    }
                    
                    
                    VStack {
                        Spacer()
                        Button(action: {showNewMessageView.toggle()}) {
                            Image(systemName: "plus.message")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .fontWeight(.bold)
                                .padding()
                        }
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(color: .gray, radius: 5)
                        .sheet(isPresented: $showNewMessageView) {
                            NewMessageView(user: $selectedUser, showChatView: $showChatView)
                        }
                    }//VStack
                    
                }
                .onAppear {
                    conversationViewModel.fetchRecentMessages()
                }
                .navigationBarTitle(userName.isEmpty ? "チャットルーム":"\(userName)のチャットルーム")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: logoutButton,trailing: EditButton())
            }
        }//nav.
    }
}

    var logoutButton: some View {
        Button{
            AuthViewModel.shared.signout()
        } label: {
            Text("ログアウト")
                .font(.system(.caption,weight: .heavy))
        }
    }



