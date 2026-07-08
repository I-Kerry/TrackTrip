
import SwiftUI

struct RouteCard: View {
    let fromText: String
    let toText: String
    
    var swap: () -> Void
    var chooseCityFrom: () -> Void
    var chooseCityTo: () -> Void
    
    var body: some View {
        ZStack(alignment: .trailing) {
            VStack(spacing: 0) {
                ReusableChooseButton(
                    placeholder: CityField.from.title,
                    text: fromText,
                    action: chooseCityFrom)
                
                ReusableChooseButton(
                    placeholder: CityField.to.title,
                    text: toText,
                    action: chooseCityTo)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(.trailing, 44)
            
            SwapButton(action: swap)
        }
        .padding(16)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(.horizontal, 16)
        
    }
}

#Preview {
    RouteCard(fromText: "Irkutsk", toText: "Dream", swap: {}, chooseCityFrom: {}, chooseCityTo: {})
}
