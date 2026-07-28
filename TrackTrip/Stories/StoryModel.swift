
import SwiftUI

struct StoryPage: Identifiable {
    let id = UUID()
    let image: Image
    let title: String
    let description: String
}

struct StoryModel: Identifiable {
    let id = UUID()
    let pages: [StoryPage]
    var isViewed: Bool = false
    var preview: Image {
        pages.first?.image ?? Image("")
    }
}
