import SwiftUI

@Observable
final class SettingsViewModel {
    private(set) var copyright: Copyright?
    private(set) var isLoading: Bool = false
    var error: AppError?
    @ObservationIgnored
    @AppStorage(DarkModeStrings.isDarkMode) var isDarkMode = false
    @ObservationIgnored
    @AppStorage(DarkModeStrings.hasUserChosenTheme) var hasUserChosenTheme = false
    
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
