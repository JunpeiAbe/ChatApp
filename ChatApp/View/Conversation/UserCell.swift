//
//  UserCell.swift
//  ChatApp
//
//  Created by Junpei  on 2022/10/27.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    
    let user:User
    
    var body: some View {
        VStack {
            HStack(spacing: 20){
                KFImage(URL(string: user.profileImageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 8){
                    Text(user.userName)
                            .font(.system(size: 20,weight: .semibold))
                            .foregroundColor(.black)
                    Text(user.fullName)
                        .font(.system(size: 12,weight: .light))
                        .foregroundColor(Color(.systemGray3))
                }
                
                Spacer()
            }
                Divider()
        }
        .padding([.horizontal,.top])
    }
}



