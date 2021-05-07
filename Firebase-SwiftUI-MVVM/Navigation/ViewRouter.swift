//
//  ViewRouter.swift
//  ThaiStories
//
//  Created by Michael Haslam on 2/28/21.
//

import SwiftUI


class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .stories
}

enum Page {
     case stories
     case profile
     case addStory
 }
