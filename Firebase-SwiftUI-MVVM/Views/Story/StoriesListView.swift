//
//  StoriesListView.swift
//  ThaiStories
//
//  Created by Michael Haslam on 2/28/21.
//

import SwiftUI

struct StoriesListView: View {
    @EnvironmentObject var storyListVM: StoryListViewModel
    var body: some View {
        ScrollView {
            VStack (spacing: 20){
                ForEach(storyListVM.storyViewModels) { storyViewModel in
                    StoryCardView(storyViewModel: storyViewModel)
                }
            }
            .padding()
        }
    }
}

struct StoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesListView().environmentObject(StoryListViewModel())
    }
}
