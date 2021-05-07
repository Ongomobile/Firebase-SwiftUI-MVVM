//
//  StoriesListView.swift
//  ThaiStories
//
//  Created by Michael Haslam on 2/28/21.
//

import SwiftUI

struct StoriesListView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        ScrollView {
            VStack (spacing: 20){
                Text("Stories List")
            }
            .padding()
        }
    }
}

struct StoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesListView().environmentObject(ViewRouter())
    }
}
