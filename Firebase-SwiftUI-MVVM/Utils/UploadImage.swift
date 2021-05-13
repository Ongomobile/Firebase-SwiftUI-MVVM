//
//  UploadImage.swift
//  Firebase-SwiftUI-MVVM
//
//  Created by Michael Haslam on 3/8/21.
//

//MIT License
//
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
import SwiftUI
import Firebase

func UploadImage(imageData: Data,path: String, completion: @escaping (URL?) -> ()){
   
    let storage = Storage.storage().reference()
    guard let uid = Auth.auth().currentUser?.uid else {return}
    
    storage.child(path).child(uid).putData(imageData, metadata: nil) { (_, err) in
        
        if err != nil{
            completion(nil)
            return
            
        }
        
        // Downloading Url And Sending Back...
        
        storage.child(path).child(uid).downloadURL { (url, err) in
            if err != nil{
                completion(nil)
                return
                
            }
            completion(url)
        }
    }
}
