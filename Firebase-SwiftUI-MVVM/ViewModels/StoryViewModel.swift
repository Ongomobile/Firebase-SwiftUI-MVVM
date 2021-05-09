//
//  StoryViewModel.swift
//  ThaiStories
//
//  Created by Michael Haslam on 3/2/21.
//

import Foundation
import Combine

class StoryViewModel: ObservableObject, Identifiable {
    private let storyRepository = StoryRepository()
    @Published var story: Story
    
    private var cancellables: Set<AnyCancellable> = []
    
    var id = ""
    
    init(story: Story) {
        self.story = story
        
        // set up binding for story between the stories id and the viewmodels
        //id then store object in cancellables so it can be canceled later
        $story
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
    
    func remove() {
        storyRepository.remove(story)
    }
    
    func editStory(story: Story) {
        storyRepository.updateStory(story)
    }
    
}
