//
//  MessageView.swift
//  ChatApp
//
//  Created by Junpei  on 2022/10/28.
//

import SwiftUI
import Kingfisher

struct MessageView: View {
    
    var messageViewModel:MessageViewModel
    
    var body: some View {
        
        //自分のメッセージ
        if messageViewModel.isFromCurrentUser{
            HStack {
                Spacer()
                Text(messageViewModel.message.text)
                    .frame(maxWidth: UIScreen.main.bounds.width * 2/5,alignment: .leading)
                    .padding(15)
                    .background(.blue)
                    .font(.system(size: 15))
                    .clipShape(ChatBubble(isFromCurrentUser: true))
                    .foregroundColor(.white)
                    .padding(.horizontal,5)
                
            }
            .padding([.top,.bottom],10)
            .padding(.trailing)
        }else{
            HStack {
                KFImage(messageViewModel.profileImageUrl)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                
                Text(messageViewModel.message.text)
                    .frame(maxWidth: UIScreen.main.bounds.width * 2/5,alignment: .leading)
                    .padding(15)
                    .background(Color(.systemGray3))
                    .font(.system(size: 15))
                    .clipShape(ChatBubble(isFromCurrentUser: false))
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
                Spacer()
            }
            .padding([.top,.bottom],10)
            .padding(.leading)
            
        }
    }
}

//struct MessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageView()
//            .previewLayout(.sizeThatFits)
//    }
//}
