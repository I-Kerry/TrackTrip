
import SwiftUI

extension CGFloat {
    static let progressBarCornerRadius: CGFloat = 6
    static let progressBarHeight: CGFloat = 6
}

struct ProgressBar: View {
    let numberOfSection: Int
    let progress: CGFloat
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(width: geometry.size.width, height: .progressBarHeight)
                    .foregroundStyle(.white)
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(
                        width: min(progress * geometry.size.width, geometry.size.width),
                        height: .progressBarHeight
                    )
                    .foregroundStyle(.blue)
            }
            .mask {
                MaskView(numberOfSection: numberOfSection)
            }
        }
    }
}

struct MaskView: View {
    let numberOfSection: Int
    var body: some View {
        HStack {
            ForEach(0..<numberOfSection, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}

struct MaskFragmentView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: .progressBarCornerRadius)
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: .progressBarHeight)
            .foregroundStyle(.blue)
    }
}

#Preview {
    ProgressBar(numberOfSection: 10, progress: 0.3)
}
