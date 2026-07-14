
import SwiftUI
import Combine

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                Text("Темная тема")
                    .foregroundStyle(.blackWhite)
                Text("Пользовательское соглашение")
                    .foregroundStyle(.blackWhite)

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
