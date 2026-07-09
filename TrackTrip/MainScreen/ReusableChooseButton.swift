
import SwiftUI

struct ReusableChooseButton: View {
    let placeholder: String
    let text: String
    
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text.isEmpty ? placeholder : text)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(text.isEmpty ? Color(.placeholderText) : .black)
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ReusableChooseButton(placeholder: "lox", text: "Ne Lox", action: {})
}
