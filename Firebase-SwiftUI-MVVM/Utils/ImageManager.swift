
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

import UIKit
import Firebase

let imageCache = NSCache<AnyObject, UIImage>()

class ImageManager {
    // MARK: PROPERTIES
    
    static let instance = ImageManager()
    
    private var REF_STOR = Storage.storage()
    
    // MARK: PUBLIC FUNCTIONS
    // Functions we call from other places in the app
    
    func uploadProfileImage(userID: String, image: UIImage, handler: @escaping (_ success: Bool) -> ()) {

        // Get the path where we will save the image
        let path = getProfileImagePath(userID: userID)

        // Save image to path
        DispatchQueue.global(qos: .userInteractive).async {
            self.uploadImage(path: path, image: image) { (success) in
                DispatchQueue.main.async {
                    handler(success)
                }
            }
        }

    }
    
    func uploadStoryImage(storyID: String, image: Data, handler: @escaping (_ success: Bool) -> ()) {
        // convert image to UIImage can force unwrap because a default image is passed if no image selected
        let image = UIImage(data: image)!
        // Get the path where we will save the image
        let path = getStoryImagePath(storyID: storyID)
      
        // Save image to path
        DispatchQueue.global(qos: .userInteractive).async {
            self.uploadImage(path: path, image: image) { (success) in
                DispatchQueue.main.async {
                    handler(success)
                }
            }
        }
    }
    
    func downloadProfileImage(userID: String, handler: @escaping (_ image: UIImage?) -> ()) {
    
        // Get the path where the image is saved
        let path = getProfileImagePath(userID: userID)
        // Download the image from path
        DispatchQueue.global(qos: .userInteractive).async {
            self.downloadImage(path: path) { (returnedImage) in
                DispatchQueue.main.async {
                    handler(returnedImage)
                }
            }
        }


    }

    func downloadStoryImage(storyID: String, handler: @escaping (_ image: UIImage?) -> ()) {

        // Get the path where the image is saved
        let path = getStoryImagePath(storyID: storyID)

        // Download the image from path
        DispatchQueue.global(qos: .userInteractive).async {
            self.downloadImage(path: path) { (returnedImage) in
                DispatchQueue.main.async {
                    handler(returnedImage)
                }
            }
        }


    }
    
    // MARK: PRIVATE FUNCTIONS
    // Functions we call from this file only
    
    private func getProfileImagePath(userID: String) -> StorageReference {
        let userPath = "users/\(userID)/profile"
        let storagePath = REF_STOR.reference(withPath: userPath)
        return storagePath
    }
    
    private func getStoryImagePath(storyID: String) -> StorageReference {
        let storyPath = "stories/\(storyID)/1"
        let storagePath = REF_STOR.reference(withPath: storyPath)
        return storagePath
    }
    
    
    private func uploadImage(path: StorageReference, image: UIImage, handler: @escaping (_ success: Bool) -> ()) {
        
        
        var compression: CGFloat = 1.0 // Loops down by 0.05
        let maxFileSize: Int = 240 * 240 // Maximum file size that we want to save
        let maxCompression: CGFloat = 0.05 // Maximum compression we ever allow
        
        // Get image data
        guard var originalData = image.jpegData(compressionQuality: compression) else {
            print("Error getting data from image")
            handler(false)
            return
        }
        
        
        // Check maximum file size
        while (originalData.count > maxFileSize) && (compression > maxCompression) {
            compression -= 0.05
            if let compressedData = image.jpegData(compressionQuality: compression) {
                originalData = compressedData
            }
        }
        
        
        // Get image data
        guard let finalData = image.jpegData(compressionQuality: compression) else {
            print("Error getting data from image")
            handler(false)
            return
        }
        
        // Get photo metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Save data to path
        path.putData(finalData, metadata: metadata) { (_, error) in
            
            if let error = error {
                //Error
                print("Error uploading image. \(error)")
                handler(false)
                return
            } else {
                //Success
                print("Success uploading image")
                handler(true)
                return
            }
            
        }
        
    }
    
    private func downloadImage(path: StorageReference, handler: @escaping (_ image: UIImage?) -> ()) {

        if let cachedImage = imageCache.object(forKey: path) {
            print("Image found in cache")
            handler(cachedImage)
            return
        } else {
            path.getData(maxSize: 27 * 1024 * 1024) { (returnedImageData, error) in

                if let data = returnedImageData, let image = UIImage(data: data) {
                    // Success getting image data
                    imageCache.setObject(image, forKey: path)
                    handler(image)
                    return
                } else {
                    print("Error getting data from path for image: \(String(describing: error?.localizedDescription))")
                    handler(nil)
                    return
                }

            }
        }

    }
}
