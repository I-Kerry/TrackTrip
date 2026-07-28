import Foundation
import SwiftUI
import Combine

final class SettingsViewModel: ObservableObject {
    @Published private(set) var copyright: Copyright?
    @Published private(set) var isLoading: Bool = false
    @Published var error: AppError?
    @AppStorage("isDarkMode") var isDarkMode = false
    @AppStorage("hasUserChosenTheme") var hasUserChosenTheme = false
    
    private var copyrightService: CopyrightServiceProtocol
    
    init(copyrightService: CopyrightServiceProtocol = Services.copyright) {
        self.copyrightService = copyrightService
        
        if !hasUserChosenTheme {
            isDarkMode = UITraitCollection.current.userInterfaceStyle == .dark
        }
    }
    
    func toggleDarkMode(_ isOn: Bool) {
        hasUserChosenTheme = true
        isDarkMode = isOn
        applyTheme(isOn)
    }
    
    func loadCopyright() async {
        isLoading = true
        
        defer { isLoading = false }
        
        error = nil
        
        do {
            copyright = try await copyrightService.getCopyright()
        } catch {
            self.error = AppError.from(error)
        }
    }
    
    private func applyTheme(_ isDark: Bool) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        scene.windows.first?.overrideUserInterfaceStyle = isDark ? .dark : .light
    }
}
