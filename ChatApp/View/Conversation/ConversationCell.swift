//
//  UserCell.swift
//  ChatApp
//
//  Created by Junpei  on 2022/10/27.
//

import SwiftUI
import Kingfisher

struct ConversationCell: View {
    
    @ObservedObject var conversationCellViewModel:ConversationCellViewModel
    
    var body: some View {
        
        if let user = conversationCellViewModel.message.user {
            NavigationLink(destination: ChatView(user: user)){
                VStack {
                    HStack(spacing: 20) {
                        KFImage(conversationCellViewModel.chatToUserProfileImageUrl)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 36)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading,spacing: 5) {
                            Text(conversationCellViewModel.userName)
                                .font(.system(size: 18,weight: .semibold))
                                .foregroundColor(.black)
                            Text(conversationCellViewModel.message.text)
                                .font(.system(size: 12))
                                .foregroundColor(Color(.systemGray3))
                        }
                    }
                }
            }
        }
    }
}

