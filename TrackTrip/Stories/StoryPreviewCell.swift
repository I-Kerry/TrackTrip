
import SwiftUI

struct StoryPreviewCell: View {
    let story: StoryModel
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            story.preview
                .resizable()
                .scaledToFill()
                .frame(width: 92, height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Text(story.pages.first?.description ?? "")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.white)
                .lineLimit(3)
                .padding(8)
        }
        .frame(width: 92, height: 140)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
            .stroke(story.isViewed ? .clear : .blue, lineWidth: 4)
        )
        .opacity(story.isViewed ? 0.5 : 1)
    }
}
