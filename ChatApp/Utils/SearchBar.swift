//
//  SearchBar.swift
//  ChatApp
//
//  Created by Junpei  on 2022/10/27.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("\(Image(systemName:"magnifyingglass"))Search", text: $text)
                .padding()
                .background(Color(.systemGray6))
                .frame(height: 40)
                .cornerRadius(8)
                .foregroundColor(.black)
            
            Button(action: {
                text = ""
            }) {
                Image(systemName:"delete.right")
                    .foregroundColor(.black)
                    .padding(.trailing, 5)
            }
        }
        .padding(.horizontal, 10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
