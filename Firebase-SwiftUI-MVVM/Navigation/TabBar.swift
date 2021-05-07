//
//  TabBar.swift
//  ThaiStories
//
//  Created by Michael Haslam on 2/28/21.
//

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

