import SwiftUI

struct ErrorView: View {
    let error: AppError
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(error.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 223, height: 223)
            
            Text(error.title)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.blackWhite)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ErrorView(error: AppError.server)
}
