
import SwiftUI

struct CopyrightView: View {
    let copyright: Copyright?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let text = copyright?.text {
                    Text(text)
                        .font(.system(size: 17, weight: .regular)).foregroundStyle(.blackWhite)
                }
                
                if let urlString = copyright?.url, let url = URL(string: urlString) {
                    Link("Data", destination: url)
                        .font(.system(size: 17, weight: .regular))
                }
            }
            .padding(16)
        }
        .navigationTitle("Пользовательское соглашение")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
    
}
