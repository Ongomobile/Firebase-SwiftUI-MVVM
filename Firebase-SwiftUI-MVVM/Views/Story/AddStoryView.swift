//
//  AddStoryView.swift
//  ThaiStories
//
//  Created by Michael Haslam on 3/7/21.
//


import SwiftUI


struct AddStoryView: View {

    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var title = ""
    @State var storyText = ""
      
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer()
                   
                    Image(systemName: "camera")
                        .resizable()
                        .cornerRadius(4)
                        .frame(width: 200 , height: 200)
                        .padding(.top)
                    
                   
                    HStack {
                        Spacer()
                        Button(action: {}) {
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
                .navigationTitle("Add A Story")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
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
}

struct AddStoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddStoryView().environmentObject(ViewRouter())
    }
}
