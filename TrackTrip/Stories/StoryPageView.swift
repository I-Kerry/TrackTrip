
import SwiftUI

struct StoryPageView: View {
    
    let story: StoryModel
    @ObservedObject var viewModel: StoriesViewModel
    
    private var isCurrent: Bool { viewModel.stories[viewModel.currentStoryIndex].id == story.id }
    
    private var pageIndex: Int { isCurrent ? viewModel.currentPageIndex : 0 }
    
    private var page: StoryPage { story.pages[pageIndex] }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                page.image
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(page.title)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                    Text(page.description)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.white)
                        .lineLimit(3)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding(.horizontal, 16)
                .padding(.bottom, 80)
                .allowsHitTesting(false)
                
                if isCurrent { tapZones }
            }
        }
        .ignoresSafeArea()
        .clipShape(RoundedRectangle(cornerRadius: 40))
        .background(Color.black)
    }
    
    private var tapZones: some View {
        HStack(spacing: 0) {
            Color.clear.contentShape(Rectangle()).onTapGesture {
                viewModel.goToPrevPage()
            }
            
            Color.clear.contentShape(Rectangle()).onTapGesture {
                viewModel.goToNextPage()
            }
        }
    }
}

#Preview {
    StoryPageView(story: StoryModel(pages: [StoryPage(image: Image(._10), title: "OMG DID I DO THAT", description: "I HOPE SO YOU KNOW, EVEN WITH AN AI I'M DOING IT SO SLOWLY")]), viewModel: StoriesViewModel(stories: [StoryModel(pages: [StoryPage(image: Image(._10), title: "OMG DID I DO THAT", description: "I HOPE SO YOU KNOW, EVEN WITH AN AI I'M DOING IT SO SLOWLY")])]))
}
