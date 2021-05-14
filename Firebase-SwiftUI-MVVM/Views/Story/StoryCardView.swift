
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

enum ActiveCardSheet: Identifiable {
    case edit, showProfile
    
    var id: Int {
        hashValue
    }
}


struct StoryCardView: View {
    @State private var storyImg: UIImage = UIImage(named: "addCameraImg")!
    @State private var authorImage: UIImage = UIImage(named: "authorImage")!
    @State private var showDetail = false
    @State private var showEditSheet = false
    @State var activeCardSheet: ActiveCardSheet?

    
    var storyViewModel: StoryViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            HStack {
                Image(uiImage: authorImage)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                    .clipShape(Circle())
                    .onTapGesture {
                        activeCardSheet = .showProfile
                    }
                Text(storyViewModel.story.author ?? "Author")
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
                LikeButton(btnAction: handleButttonTap)
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

        .sheet(item: $activeCardSheet) { item  in
            switch item {
            case .edit:
                EditStoryView(storyViewModel: StoryViewModel(story: storyViewModel.story))
            case .showProfile:
                StoryAuthorProfileView(storyUserID: storyViewModel.story.userId ?? "")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(4)
        .shadow(color: Color("BrandPrimary").opacity(0.15), radius: 30, x: 0, y: 2)
    }
    private  func handleButttonTap(){
        print("Like Button tapped")
    }
}

