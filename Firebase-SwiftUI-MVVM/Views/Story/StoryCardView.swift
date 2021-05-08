//
//  StoryCardView.swift
//  ThaiStories
//
//  Created by Michael Haslam on 3/7/21.
//

import SwiftUI

struct StoryCardView: View {
    @State private var storyImg: UIImage = UIImage(named: "addCameraImg")!
    @State private var showDetail = false
    @State private var showEditSheet = false
    
    var storyViewModel: StoryViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                Text("Author")
                    .foregroundColor(Color("TextColor"))
                    .font(.title2)
                Spacer()
                if storyViewModel.story.userId == AuthenticationService.instance.user?.uid{
                    Menu("...") {
                        Button(action: {storyViewModel.remove()}){
                            Text("Delete story")
                            Image(systemName: "trash")
                        }
                        Button(action: {showEditSheet.toggle()}){
                            Text("Edit story")
                            Image(systemName: "square.and.pencil")
                        }
                    }
                   
                }
            }
            Image(uiImage: UIImage(data:storyViewModel.story.storyImage!) ?? storyImg)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack {
                Button(action: {}) {
                    Image(systemName: "heart")
                        .font(.title3)
                        .foregroundColor(Color("BrandPrimary"))

                }
                Button(action: {}) {
                    Image(systemName: "bubble.right")
                        .font(.title3)
                        .foregroundColor(Color("BrandPrimary"))
                }
               
                Spacer()
                Button(action: {showDetail.toggle()}) {
                    Text("more...")
                        .foregroundColor(Color("TextColor")).opacity(0.6)
                        .font(.headline)
                }
            }
            .padding(.top)
            if showDetail {
                VStack (alignment: .leading, spacing: 5){
                    Text("5 Likes")
                    Text(storyViewModel.story.headline ?? "")
                        .font(.title)
                        .foregroundColor(Color("TextColor"))
                    Text(storyViewModel.story.bodyText ?? "")
                }
                .padding(.top)
            }
          
        }

        .sheet(isPresented: $showEditSheet) {
            EditStoryView(storyViewModel: StoryViewModel(story: storyViewModel.story))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(4)
        .shadow(color: Color("BrandPrimary").opacity(0.15), radius: 30, x: 0, y: 2)
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryCardView(storyViewModel: StoryViewModel(story: Story(id: "1",headline: "", bodyText: "", userId: "", storyId: "", createdAt: Date())))
    }
}
