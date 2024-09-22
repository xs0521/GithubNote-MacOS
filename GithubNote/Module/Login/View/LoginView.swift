//
//  LoginView.swift
//  GithubNote
//
//  Created by xs0521 on 2024/4/4.
//

import SwiftUI
import Foundation

typealias StartCompletionCallBack = () -> ()

struct LoginView: View {
    
    @State var ownerName = ""
    @State var repoName = ""
    @State var token = ""
    
    var completion: StartCompletionCallBack?
    
    var body: some View {
        VStack {
            Text("Github Note")
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 60, trailing: 10))
                .font(.largeTitle)
            
            TextField(AccountType.owner.title, text: $ownerName)
                .frame(width: 300, height: 44)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .textFieldStyle(.plain)
            
            TextField(AccountType.repo.title, text: $repoName)
                .frame(width: 300, height: 44)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .textFieldStyle(.plain)
                
            TextField(AccountType.token.title, text: $token)
                .frame(width: 300, height: 44)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .textFieldStyle(.plain)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 40, trailing: 10))
            
            Button(action: {
                "start".logI()
                if !enbleStart() {
                    return
                }
                UserDefaults.save(value: ownerName, key: AccountType.owner.key)
                UserDefaults.save(value: repoName, key: AccountType.repo.key)
                UserDefaults.save(value: token, key: AccountType.token.key)
                completion?()
                
            }, label: {
                Text("start")
                    .foregroundStyle(enbleStart() ? Color.black : Color(white: 0.4745))
            })
            .frame(width: 120, height: 40)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .buttonStyle(.plain)
            .disabled(!enbleStart())
        }
        .frame(width: AppConst.defaultWidth, height: AppConst.defaultHeight)
    }
    
    func enbleStart() -> Bool {
        return !repoName.isEmpty && !ownerName.isEmpty
    }
}

#Preview {
    LoginView()
}
