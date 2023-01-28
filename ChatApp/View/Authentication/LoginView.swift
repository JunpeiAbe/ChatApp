//
//  LoginView.swift
//  ChatApp
//
//  Created by Junpei  on 2022/10/27.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authViewModel:AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 20) {
                    CustomTextField(imageName: "envelope", placeholderText: "e-mail", isSecureField: false, text: $email)
                    
                    CustomTextField(imageName: "lock", placeholderText: "password", isSecureField: false, text: $password)
                }
                
                HStack {
                    Spacer()
                    NavigationLink(
                        destination: ResetPasswordView(email: $email).navigationTitle("パスワードのリセット").navigationBarBackButtonHidden(),
                        label: {
                            Text("パスワードを忘れた")
                                .font(.system(size: 13, weight: .semibold))
                                .padding(.top)
                                .padding(.trailing, 28)
                        })
                }
                
                Button(action: {
                    authViewModel.login(withEmail: email, password: password)}) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340,height: 50)
                        .background(.cyan)
                        .cornerRadius(20)
                }
                .padding(.top, 20)
                .shadow(color: .gray, radius: 5)
                
                NavigationLink(
                    destination:{
                        RegisterView().navigationTitle("ユーザー登録").navigationBarBackButtonHidden()}) {
                    Text("アカウントをお持ちでない方はコチラ")
                        .font(.system(size: 14))
                    Text("Sign Up")
                        .font(.system(size: 14,weight: .bold))
                }
                .padding(.top, 20)
            }
            .navigationBarTitle("ログイン")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


