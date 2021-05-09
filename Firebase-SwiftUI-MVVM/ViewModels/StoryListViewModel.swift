//
//  StoryListViewModel.swift
//  ThaiStories
//
//  Created by Michael Haslam on 3/7/21.
//

import Foundation
import Combine

class StoryListViewModel: ObservableObject  {
    
    @Published var storyRepository = StoryRepository()
    
    @Published var storyViewModels: [StoryViewModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        storyRepository.$stories.map { stories in
            stories.map(StoryViewModel.init)
        }
        .assign(to: \.storyViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func addStory(story: Story) {
        storyRepository.uploadStory(story: story)
    }
    
}
