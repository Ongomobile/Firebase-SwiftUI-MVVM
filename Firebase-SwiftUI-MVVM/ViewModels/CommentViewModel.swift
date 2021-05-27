//
//  CommentViewModel.swift
//  ThaiFoody
//
//  Created by Michael Haslam on 5/26/21.
//

import Foundation
import Combine

class CommentViewModel: ObservableObject, Identifiable {
    @Published var showProfile = false
    private let storyRepository = StoryRepository()
    
    func addComment(id: String, comment: Comment) {
        storyRepository.addComment(id: id, comment: comment)
    }
    
    func deleteComment(id: String, comment: Comment) {
     
        storyRepository.deleteComment(docId: id, comment: comment)
    }
}
