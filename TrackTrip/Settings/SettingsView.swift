
import SwiftUI
import Combine

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    List {
                        HStack(alignment: .top, spacing: 20) {
                            Text("Темная тема").font(.system(size: 17, weight: .regular)).foregroundStyle(.blackWhite)
                            Spacer()
                            Toggle("", isOn: $viewModel.isDarkMode)
                                .labelsHidden()
                                .onChange(of: viewModel.isDarkMode) { viewModel.toggleDarkMode($0) }
                        }
                        
                        
                        NavigationLink {
                            CopyrightView(copyright: viewModel.copyright)
                        } label: {
                            HStack {
                                Text("Пользовательское соглашение").font(.system(size: 17, weight: .regular)).foregroundStyle(.blackWhite)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                    .background(Color.clear)
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 16) {
                        Text("Приложение использует API «Яндекс.Расписания»")
                            .font(.system(size: 12, weight: .regular)).foregroundStyle(.blackWhite)
                        Text("Версия 1.0 (beta)")
                            .font(.system(size: 12, weight: .regular)).foregroundStyle(.blackWhite)
                    }
                    .padding(.bottom, 24)
                    .padding(.horizontal, 16)
                }
            }
            .task {
                await viewModel.loadCopyright()
            }
        }
    }
}
#Preview {
    SettingsView(viewModel: SettingsViewModel())
}
