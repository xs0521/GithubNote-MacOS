//
//  NoteIssuesHeaderView.swift
//  GithubNote
//
//  Created by xs0521 on 2024/9/22.
//

import SwiftUI

struct NoteIssuesHeaderView: View {
    
    @State private var isNewIssueSending: Bool = false
    
    var createIssueCallBack: (_ issue: Issue) -> ()
    var issueSyncCallBack: (_ callBack: @escaping CommonCallBack) -> ()
    
    var body: some View {
        HStack {
            Text("NoteBook")
                .padding(.leading, 16)
            Spacer()
            HStack {
                Button {
                    issueSyncCallBack({})
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                }
                .buttonStyle(.plain)
                .padding(.trailing, 5)
                if isNewIssueSending {
                    ProgressView()
                        .controlSize(.mini)
                        .frame(width: 20, height: 30)
                } else {
                    Button {
                        createIssue()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.plain)
                    .frame(width: 20, height: 30)
                }
            }
            .frame(width: 40, height: 40)
            .padding(.trailing, 12)
        }
    }
    
    
}

extension NoteIssuesHeaderView {
    
    func createIssue() -> Void {
        isNewIssueSending = true
        let title = AppConst.issueMarkdown
        let body = AppConst.issueBodyMarkdown
        Networking<Issue>().request(API.newIssue(title: title, body: body), writeCache: false, readCache: false) { data, cache, _ in
            guard let issue = data?.first else {
                isNewIssueSending = false
                return
            }
            createIssueCallBack(issue)
            isNewIssueSending = false
        }
    }
}

//#Preview {
//    NoteIssuesHeaderView()
//}
