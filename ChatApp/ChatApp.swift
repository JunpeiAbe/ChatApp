//
//  ChatApp.swift
//  ChatApp
//
//  Created by Junpei  on 2022/10/27.
//

import SwiftUI
import Firebase



@main
struct ChatApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            
            ContentView().environmentObject(AuthViewModel.shared)
            
        }
    }
}
