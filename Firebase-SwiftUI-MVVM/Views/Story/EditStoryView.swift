
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
