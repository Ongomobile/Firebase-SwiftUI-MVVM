
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

struct StoryAuthorProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var profileImage: UIImage = UIImage(named: "addCameraImg")!
    @State private var username = "Username"
    @State private var bio = "Bio"
    
    let storyUserID: String
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Text("X")
                        .foregroundColor(Color("BrandPrimary"))
                }
                Spacer()
            }
            Image(uiImage: profileImage)
                .resizable()
                .cornerRadius(4)
                .frame(width: 175, height: 175)
                .padding(.top)
            
            HStack {
                Spacer()
                Text(username)
                Spacer()
            }
            .foregroundColor(Color("TextColor").opacity(0.6))
            VStack(alignment: .leading) {
                Text("Bio")
                    .foregroundColor(Color("TextColor").opacity(0.6))
                Text(bio)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, alignment: .topLeading)
                    .font(.system(size: 17))
                    .padding()
                    .foregroundColor(Color("TextColor").opacity(0.7))
                    .overlay(RoundedRectangle(cornerRadius: 6)
                                .stroke(Color("TextColor").opacity(0.5), lineWidth: 1))
            }

            Spacer()
        }
        .padding()
        .onAppear {
            getAuthorProfile()
        }
    }
    private func getAuthorProfile(){
        //code here
    }
}

struct StoryAuthorProfileView_Previews: PreviewProvider {
    static var previews: some View {
        StoryAuthorProfileView(storyUserID: "123")
    }
}
