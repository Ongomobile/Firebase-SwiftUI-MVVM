
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


import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import Combine
import PhotosUI

class StoryRepository: ObservableObject {
    private let path: String = "stories"
    private let store = Firestore.firestore()
    private let storage = Storage.storage()
   
    @Published var stories: [Story] = []
    
    var userId = ""

    private let authenticationService = AuthenticationService()
   
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
      authenticationService.$user
        .compactMap { user in
          user?.uid
        }
        .assign(to: \.userId, on: self)
        .store(in: &cancellables)

      authenticationService.$user
        .receive(on: DispatchQueue.main)
        .sink { [weak self] _ in
          self?.get()
        }
        .store(in: &cancellables)
    }
    
    func get(){
        store.collection(path)
            .addSnapshotListener{ querySnapshot, error in
                if let error = error {
                    print("Error getting stories: \(error.localizedDescription)")
                    return
                }
                
                let stories = querySnapshot?.documents.compactMap {document in
//                    Map every document as a Story using data(as:decoder:). You can do this thanks to FirebaseFirestoreSwift,because Story conforms to Codable.
                    try? document.data(as: Story.self)
                } ?? []
                
                DispatchQueue.main.async {
                    self.stories = stories
                }
            }
    }
    
    func uploadStory(story: Story) {
        let document = store.collection(path).document()
        let storyID = document.documentID
        
        ImageManager.instance.uploadStoryImage(storyID: storyID, image: story.storyImage!) { (_ success: Bool) in
            
            if success {
                do {
                    var newStory = story
                     newStory.userId = self.userId
                     newStory.storyId = storyID
                    _ = try self.store.collection(self.path).addDocument(from: newStory)
                } catch {
                    fatalError("Unable to add card: \(error.localizedDescription).")
                }
              return
            } else {
                print("Error uploading post image to firebase")
                return
            }
        }
    }

    func remove(_ story: Story) {
        guard let storyId = story.storyId else { return }
        guard let docId = story.id else { return}
       
        store.collection(path).document(docId).delete { error in
            if let error = error {
                print("Unable to remove card: \(error.localizedDescription)")
            }  else {
                print("Successfully deleted  story text")
            }
        }
        storage.reference().child("stories/\(storyId)/1").delete { error in
            if let error = error {
                print("Unable to delete story image: \(error.localizedDescription)")
            } else {
                print("Successfully deleted  story image")
            }
        }

    }
    
    func updateStory(_ story: Story) {
        guard let storyDocId = story.id else { return }
      
        ImageManager.instance.uploadStoryImage(storyID: story.storyId ?? "", image: story.storyImage!) { (_ success: Bool) in

            if success {
                do {
                    try self.store.collection(self.path).document(storyDocId).setData(from: story)
                } catch {
                    fatalError("Unable to add card: \(error.localizedDescription).")
                }
              return
            } else {
                print("Error uploading post image to firebase")
                return
            }
        }
    }
    
    func addComment(id: String, comment: Comment) {
        let commentData: [String: Any] = [
            "id" : comment.id as Any,
            "userId" : comment.userId,
            "storyId" : comment.storyId,
            "commentText" : comment.commentText
        ]
        store.collection(path).document(id).updateData([
            "comments" : FieldValue.arrayUnion([commentData])
        ])
    }
    
    func deleteComment(docId: String,comment: Comment) {
        let commentData: [String: Any] = [
            "id" : comment.id,
            "userId" : comment.userId,
            "storyId" : comment.storyId,
            "commentText" : comment.commentText
        ]
   
        DispatchQueue.main.async {
            self.store.collection(self.path).document(docId).updateData([
                "comments" : FieldValue.arrayRemove([commentData])
            ])
        }
       
    }
    
}
