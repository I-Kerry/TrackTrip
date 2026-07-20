
import SwiftUI

struct SearchButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Найти")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 150, height: 60)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 16)
    }
}

#Preview {
    SearchButton(action: {})
}
