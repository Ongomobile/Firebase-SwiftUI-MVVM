

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

struct AddStoryView: View {

    @EnvironmentObject var storyListVM: StoryListViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State var title = ""
    @State var storyText = ""
    @State var imgSelected: UIImage = UIImage(named: "addCameraImg")!
    
    @State var showAddPhotoSheet = false

  
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer()
                   
                    Image(uiImage: imgSelected)
                        .resizable()
                        .cornerRadius(4)
                        .frame(width: 200 , height: 200)
                        .padding(.top)
                    
                   
                    HStack {
                        Spacer()
                        Button(action: {showAddPhotoSheet.toggle()}) {
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
                .padding()
                .sheet(isPresented: $showAddPhotoSheet){
                    ImagePicker(imageSelected: $imgSelected, sourceType: $sourceType)
                }
                .navigationTitle("Add A Story")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                           addStory()
                            viewRouter.currentPage = .stories
                        }) {
                            Text("Save")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            viewRouter.currentPage = .stories
                        }) {
                            Text("Cancel")
                        }
                    }
                }
            }
            
        }
    }
    
    private func addStory() {
        let imageData = imgSelected.jpegData(compressionQuality: 0.01)
        let storyToAdd = Story(headline: title, bodyText: storyText, storyImage: imageData,createdAt: Date())
        storyListVM.addStory(story: storyToAdd)
    }
}

struct NewStoryForm_Previews: PreviewProvider {
    static var previews: some View {
        AddStoryView().environmentObject(StoryListViewModel())
    }
}
