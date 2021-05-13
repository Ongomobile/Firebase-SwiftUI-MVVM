//
//  TabBar.swift
//  ThaiStories
//
//  Created by Michael Haslam on 2/28/21.
//

//MIT License
//
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

struct TabBar: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewRouter: ViewRouter
           
    var body: some View {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    switch viewRouter.currentPage {
                    case .stories:
                        StoriesListView()
                    case .profile:
                        ProfileView()
                    case .addStory:
                        AddStoryView()
                    }
                    Spacer()
                    ZStack {
                        HStack {
                            TabBarIcon(assignedPage: .stories, width: geometry.size.width/3, height: geometry.size.height/28, systemIconName: "list.bullet", tabName: "Stories")
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                                    .shadow(radius: 4)
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width/7-6 , height: geometry.size.width/7-6)
                                    .foregroundColor(Color("BrandPrimary"))
                            }
                            .offset(y: -geometry.size.height/8/2)
                            .onTapGesture {
                                withAnimation {
                                    viewRouter.currentPage = .addStory
                                }
                            }
                            TabBarIcon(assignedPage: .profile,width: geometry.size.width/3, height: geometry.size.height/28, systemIconName: "person", tabName: "Profile")
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color("TabBarBg").shadow(radius: 2))
                    }
                }
              
                
            }
            .edgesIgnoringSafeArea(.bottom)
    }
    
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar().environmentObject(ViewRouter())
    }
}

