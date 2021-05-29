//
//  CommentView.swift
//  ThaiFoody
//
//  Created by Michael Haslam on 5/25/21.
//

import SwiftUI

struct CommentView: View {
    @EnvironmentObject var commentVM: CommentViewModel
    
    private let storyRepository = StoryRepository()
    
    @State var openActionSheet = false
    @State var showDeleteAlert = false
    let storyId: String?
    let userComment: Comment
  
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            VStack {
                Text("\(userComment.commentText)")
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .padding()
                
            }
            .background(Color("BrandPrimary").opacity(0.05))
            .cornerRadius(15)
            .onTapGesture {
                openActionSheet.toggle()
            }
            
            Spacer()
        }
        .actionSheet(isPresented: $openActionSheet) {
            ActionSheet(title: Text(""), buttons: [
                .default(Text("Edit Comment")
                            .font(.title)
                            .foregroundColor(.purple)
                         ,action: {print("Called edit comment")}),
                .default(Text("Delete Comment"), action: {showDeleteAlert.toggle()}),
                .cancel(Text("Cancel"), action: { })
                
            ])
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(title: Text("Are you sure?"),
                  primaryButton: Alert.Button.cancel(),
                  
                  secondaryButton: Alert.Button.destructive(Text("Delete"), action: {
                    deleteComment()
                  }))
            
        }
    }
    
    private func deleteComment() {
        guard let id = storyId else { return }
        commentVM.deleteComment(id: id, comment: userComment)
    }
}




