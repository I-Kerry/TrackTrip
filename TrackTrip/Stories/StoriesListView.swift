

import SwiftUI

struct StoriesListView: View {
    @StateObject private var viewModel = StoriesViewModel()
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                ForEach(viewModel.stories.indices, id: \.self) { story in
                    StoryPreviewCell(story: viewModel.stories[story])
                        .onTapGesture {
                            viewModel.open(story)
                        }
                }
            }
            .padding(.horizontal)
            .frame(height: 140)
        }
        .scrollIndicators(.hidden)
        .fullScreenCover(isPresented: $viewModel.isPresented) {
            StoriesContainerView(viewModel: viewModel)
        }
    }
}

#Preview {
    StoriesListView()
}
