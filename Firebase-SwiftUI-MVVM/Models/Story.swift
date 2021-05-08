//
//  StoryModel.swift
//  ThaiStories
//
//  Created by Michael Haslam on 3/2/21.
//

import Foundation
import FirebaseFirestoreSwift

struct Story: Identifiable, Codable {
    @DocumentID var id: String?
    var headline :String?
    var bodyText: String?
    var userId: String?
    var storyId: String?
    var storyImage: Data?
    var createdAt: Date
}


