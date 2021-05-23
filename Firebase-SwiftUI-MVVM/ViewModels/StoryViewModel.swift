
//Copyright (c) [2021] [Michael Haslam]
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

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
    
    func addComment(id: String, comment: Comment) {
        storyRepository.addComment(id: id, comment: comment)
    }
    
}
