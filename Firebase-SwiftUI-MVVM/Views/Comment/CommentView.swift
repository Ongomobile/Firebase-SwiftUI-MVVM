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
    
    @State var showDeleteAlert = false
   
    let storyId: String?
    let userComment: Comment
  
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            HStack {
                VStack {
                    Text("\(userComment.commentText)")
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .padding()
                    
                }
                .background(Color("BrandPrimary").opacity(0.05))
                .cornerRadius(15)
               
            }
            if AuthenticationService.instance.user?.uid == userComment.userId{
              Text("...")
                .onTapGesture {
                    showDeleteAlert.toggle()
                 }
            }
            Spacer()
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(title: Text("Are you sure you want to delete comment?"),
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




