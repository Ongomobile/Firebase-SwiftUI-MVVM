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

struct CommentListView: View {
    @State var containerHeight: CGFloat = 0
    @State var text = ""
    var storyViewModel: StoryViewModel
    
    var body: some View {
        ZStack (alignment: .bottomLeading){
            ScrollView {
                VStack(alignment: .leading, spacing: 50){
                    ForEach(storyViewModel.story.comments!, id: \.self) { comment in
                        HStack(alignment: .top, spacing: 15) {
                            Text(comment)
                            Spacer()
                        }
                    }
                }
                .padding(.bottom, 80)
                .padding(.horizontal)
            }
            HStack {
                AutoSizingTextField(hint: "Add Comment", text: $text, containerHeight: $containerHeight) {
                    addComment()
                    text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .padding(.horizontal)
                // Your Max Height Here....
                .frame(height: containerHeight <= 120 ? containerHeight : 120)
                .background(Color("BrandPrimary").opacity(0.05))
                .cornerRadius(10)
                .padding()
            }
            .background(Color.white)
        }
        .padding(.bottom, 30)
    }
    
    private func addComment() {
        guard let id = storyViewModel.story.id else { return }
        storyViewModel.addComment(id: id, comment: text)
    }
    
}
