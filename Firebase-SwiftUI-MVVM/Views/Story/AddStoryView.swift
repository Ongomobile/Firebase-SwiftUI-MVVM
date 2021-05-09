//
//  AddStoryView.swift
//  ThaiStories
//
//  Created by Michael Haslam on 3/7/21.
//


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
