//
//  EditStoryView.swift
//  ThaiFoody
//
//  Created by Michael Haslam on 4/23/21.
//

import SwiftUI

struct EditStoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var storyListVM: StoryListViewModel
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var editImage: UIImage = UIImage(named: "addCameraImg")!
    @State private var showPicker = false
    @State private var title = ""
    @State private var storyText = ""
    
    var storyViewModel: StoryViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        
                        Image(systemName: "xmark")
                            .foregroundColor(Color("BrandPrimary"))
                    }
                    Spacer()
                    Text("Edit Story")
                        .font(.system(size: 25, weight: .heavy))
                        .foregroundColor(Color("TextColor"))
                    Spacer()
                    
                    Button(action: {
                        update()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        
                        Text("Save")
                            .foregroundColor(Color("BrandPrimary"))
                    }
                }
                
                Image(uiImage: editImage)
                    .resizable()
                    .cornerRadius(4)
                    .frame(width: 200 , height: 200)
                    .padding(.top)
                
                
                HStack {
                    Spacer()
                    Button(action: {showPicker.toggle()}) {
                        
                        Text("Add a photo")
                            .foregroundColor(Color("BrandPrimary"))
                    }
                    Spacer()
                    
                }
                
                VStack {
                    TextField("Enter title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.top)
                HStack {
                    Text("Story text")
                        .foregroundColor(Color("TextColor")).opacity(0.8)
                        .padding(.top)
                    Spacer()
                }
                TextEditor(text: $storyText)
                    .foregroundColor(Color("TextColor"))
                    .frame(height: 180)
                    .overlay(RoundedRectangle(cornerRadius: 4)
                                .stroke(Color("TextColor").opacity(0.2), lineWidth: 1))
                
                
            }
            .onAppear {
                getStoryImage()
                title = storyViewModel.story.headline ?? ""
                storyText = storyViewModel.story.bodyText ?? ""
            }
            .padding()
            .sheet(isPresented: $showPicker){
                ImagePicker(imageSelected: $editImage, sourceType: $sourceType)
            }
        }
    }
    private func getStoryImage() {
         ImageManager.instance.downloadStoryImage(storyID: storyViewModel.story.storyId ?? "") { (returnedImage) in
             if let image = returnedImage {
                 DispatchQueue.main.async {
                     self.editImage = image
                 }
             }
             
         }
     }
    
    func update(){
        let imageData = editImage.jpegData(compressionQuality: 0.01)
        var updatedStory = storyViewModel.story
        updatedStory.headline = title
        updatedStory.bodyText = storyText
        updatedStory.createdAt = Date()
        updatedStory.storyImage = imageData
        
        storyViewModel.editStory(story: updatedStory)
    }
}

//struct EditStoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditStoryView(storyViewModel: StoryViewModel(story: Story()) ).environmentObject(StoryListViewModel())
//    }
//}
