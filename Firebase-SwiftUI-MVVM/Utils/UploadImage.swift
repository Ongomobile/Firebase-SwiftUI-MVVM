//
//  UploadImage.swift
//  Firebase-SwiftUI-MVVM
//
//  Created by Michael Haslam on 3/8/21.
//

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
