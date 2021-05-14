
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

struct LikeButton : View {
    @State var isPressed = false
    @State var scale : CGFloat = 1
    @State var opacity  = 0.0
    
    var body: some View {
        ZStack {
            Image(systemName: "heart.fill")
                .font(.title3)
                .foregroundColor(Color("BrandPrimary"))
                .opacity(isPressed ? 1 : 0)
                .scaleEffect(isPressed ? 1.0 : 0.1)
                .animation(.linear)
            Image(systemName: "heart")
                .font(.title3)
                .foregroundColor(Color("BrandPrimary"))
        }.font(.system(size: 40))
        .onTapGesture {
                 self.isPressed.toggle()
                 withAnimation (.linear(duration: 0.2)) {
                      self.scale = self.scale == 1 ? 1.3 : 1
                      self.opacity = self.opacity == 0 ? 1 : 0
                  }
                  withAnimation {
                      self.opacity = self.opacity == 0 ? 1 : 0
                  }
         }
        .scaleEffect(self.scale)
        .foregroundColor(isPressed ? .red : .white)
    }
}

struct LikeButton_Previews: PreviewProvider {
    static var previews: some View {
        LikeButton()
    }
}