//
//  ContentView.swift
//  ChatApp
//
//  Created by Junpei  on 2022/10/27.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authViewModel:AuthViewModel
   
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                ConversationView()
            }else{
                LoginView()
            }
        }
    }
}


