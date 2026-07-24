
import SwiftUI

struct CloseButton: View {
    let close: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button {
                close()
            } label: {
                Image(systemName: "xmark.circle.fill")
            }
            .font(.system(size: 24))
            .foregroundStyle(.white, .black)
        }
    }
}

#Preview {
    CloseButton(close: { })
}
