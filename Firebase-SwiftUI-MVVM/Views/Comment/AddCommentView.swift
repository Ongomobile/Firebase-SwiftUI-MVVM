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

struct AddCommentView: View {
    @Environment(\.presentationMode) var presentationMode
    // Auto Updating TextBox Height...
    @State var containerHeight: CGFloat = 0

    @State var text: String = ""
    
    var body: some View {
        HStack {
            AutoSizingTextField(hint: "Add Comment", text: $text, containerHeight: $containerHeight) {
                print("\(text) the is value from TextField")
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
    }
    
    private func addComment() {
        print("Add Comment Called")
    }
}

struct AddComment_Previews: PreviewProvider {
    static var previews: some View {
        AddCommentView()
    }
}
