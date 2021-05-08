//
//  StoryRepository.swift
//  ThaiStories
//
//  Created by Michael Haslam on 3/2/21.
//

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
    
}
