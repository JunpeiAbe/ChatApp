//
//  CustomInputView.swift
//  ChatApp
//
//  Created by Junpei  on 2022/10/27.
//

import SwiftUI

struct CustomInputView: View {
    
    @Binding var messageText: String
    
    
    var sendAction: () -> Void
    
    var body: some View {
        VStack {
            Divider()
            HStack {
                TextField("Message",text: $messageText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.body)
                    .frame(minHeight:30)
                Button(action: sendAction) {
                    Image(systemName: "paperplane")
                        .resizable()
                        .frame(width: 25,height: 25)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal,20)
            .padding(.bottom, 10)
        }
    }
}

//struct CustomInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomInputView(text: .constant(""))
//    }
//}
