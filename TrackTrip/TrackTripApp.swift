
import SwiftUI

@main
struct TrackTripApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
