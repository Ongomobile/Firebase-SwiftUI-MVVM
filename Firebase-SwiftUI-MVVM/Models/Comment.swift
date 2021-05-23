//
//  Comment.swift
//  Firebase-SwiftUI-MVVM
//
//  Created by Michael Haslam on 5/23/21.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Comment: Identifiable, Codable, Hashable {
    var id: String
    var userId: String
    var storyId: String
    var commentText: String
    var createdAt: Date
}
