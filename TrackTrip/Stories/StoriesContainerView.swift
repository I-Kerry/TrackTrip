
import SwiftUI

struct StoriesContainerView: View {
    @ObservedObject var viewModel: StoriesViewModel
    
    var body: some View {
        ZStack {
            TabView(selection: $viewModel.currentStoryIndex) {
                ForEach(viewModel.stories.indices, id: \.self) { story in
                    StoryPageView(story: viewModel.stories[story], viewModel: viewModel)
                        .tag(story)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
            
            ZStack(alignment: .top) {
                StoriesProgressBar(
                    storiesCount: viewModel.currentStory.pages.count,
                    timerConfiguration: viewModel.timerConfiguration,
                    currentProgress: $viewModel.currentProgress,
                    onFinished: { viewModel.nextStory() }
                )
                .frame(height: .progressBarHeight)
                .padding(.horizontal, 24)

                VStack(spacing: 4) {
                    Spacer()
                        .frame(height: 10)

                    HStack {
                        Spacer()
                        CloseButton(close: viewModel.close)
                    }
                    .padding(.horizontal, 24)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.top, 28)
            
        }
        .background(Color.black)
        .onChange(of: viewModel.currentStoryIndex) { newIndex in
            viewModel.currentProgress = 0
            viewModel.markViewed(newIndex)
            
        }
        
    }
    
}

#Preview {
    StoriesContainerView(viewModel: StoriesViewModel(stories: [StoryModel(pages: [StoryPage(image: Image(._10), title: "LOL", description: "LMAO")])]))
}
