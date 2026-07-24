
import SwiftUI
import Combine

final class StoriesViewModel: ObservableObject {
    @Published var stories: [StoryModel]
    @Published var currentStoryIndex: Int = 0
    @Published var currentProgress: CGFloat = 0
    @Published var isPresented: Bool = false
    
    init(stories: [StoryModel] = StoriesData.photos) {
        self.stories = stories
    }
    
    var currentStory: StoryModel {
        stories[currentStoryIndex]
    }
    
    var timerConfiguration: TimerConfiguration {
        TimerConfiguration(storiesCount: currentStory.pages.count)
    }
    
    var currentPageIndex: Int {
        timerConfiguration.index(for: currentProgress)
    }
    
    var currentPage: StoryPage {
        currentStory.pages[currentPageIndex]
    }
    
    func open(_ index: Int) {
        currentStoryIndex = index
        currentProgress = 0
        markViewed(index)
        isPresented = true
    }
    
    func markViewed(_ index: Int) {
        stories[currentStoryIndex].isViewed = true
    }
    
    func goToNextPage() {
        let next = currentPageIndex + 1
        if next < currentStory.pages.count {
            currentProgress = timerConfiguration.progress(for: next)
        } else {
            nextStory()
        }
    }
    
    func goToPrevPage() {
        let prev = currentPageIndex - 1
        if prev >= 0 {
            currentProgress = timerConfiguration.progress(for: prev)
        } else {
            prevStory()
        }
    }
    
    func nextStory() {
        guard currentStoryIndex < stories.count - 1 else { return close() }
        currentStoryIndex += 1
        currentProgress = 0
        markViewed(currentStoryIndex)
    }
    
    func prevStory() {
        guard currentPageIndex > 0 else { return close() }
        currentStoryIndex -= 1
        currentProgress = 0
    }
    
    func close() {
        isPresented = false
    }
}
