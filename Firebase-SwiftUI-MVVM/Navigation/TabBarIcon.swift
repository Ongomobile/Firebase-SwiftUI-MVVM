//
//  TabBarIcon.swift
//  ThaiFoody
//
//  Created by Michael Haslam on 4/16/21.
//

import SwiftUI

struct TabBarIcon: View {
    @EnvironmentObject var viewRouter: ViewRouter
   
    let assignedPage: Page
    let width, height: CGFloat
    let systemIconName, tabName: String
    
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tabName)
                .font(.footnote)
            Spacer()
        }
        .onTapGesture {
            viewRouter.currentPage = assignedPage
        }
        .foregroundColor(viewRouter.currentPage == assignedPage ? Color("TabBarHighlight") : .gray)
        .padding(.top)
    }
}
//struct TabBarIcon_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarIcon()
//    }
//}
