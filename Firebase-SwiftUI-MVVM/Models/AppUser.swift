//
//  UserModel.swift
//  ThaiStories
//
//  Created by Michael Haslam on 3/8/21.
//

import SwiftUI
import FirebaseFirestoreSwift

struct AppUser: Identifiable, Codable {
    @DocumentID var id: String?
    var username: String?
    var userId: String?
    var email: String?
    var createdAt: Date
    var profileImage: Data?
    var bio: String?
}
