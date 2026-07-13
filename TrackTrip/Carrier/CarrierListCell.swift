
import SwiftUI

struct CarrierListCell: View {
    let trip: CarrierTrip
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            header
            timeline
        }
        .padding(16)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
    
    private var header: some View {
        HStack {
            carrierLogo
            VStack(alignment: .leading, spacing: 2) {
                Text(trip.carrierTitle)
                    .font(.system(size: 17, weight: .regular))
                if trip.hasTransfer, let city = trip.transferCityTitle {
                    Text("с пересадкой в \(city)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.red)
                }
            }
            Spacer()
            Text(trip.dateText)
                .font(.system(size: 12, weight: .regular))
        }
    }
    
    private var timeline: some View {
        HStack(spacing: 8) {
            VStack(spacing: 4) {
                HStack(spacing: 2) {
                    Text(trip.departureTime)
                        .font(.system(size: 17, weight: .regular))
                    Rectangle()
                        .frame(height: 1)
                    Text(trip.durationText)
                        .font(.system(size: 12, weight: .regular))
                        .lineLimit(1)
                    Rectangle()
                        .frame(height: 1)
                    Text(trip.arrivalTime)
                        .font(.system(size: 17, weight: .regular))
                }
            }
            .frame(maxWidth: .infinity) 
        }
    }
    
    private var carrierLogo: some View {
        AsyncImage(url: trip.carrierLogoURL) { image in
            image.resizable().scaledToFit()
        } placeholder : {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.3))
        }
        .frame(width: 38, height: 38)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    CarrierListCell(trip: CarrierTrip(id: "1", carrierTitle: "PZD", carrierLogoURL: nil, dateText: "SEGODNYA", departureTime: "V CHAS", arrivalTime: "V DVA", durationText: "NU TOZHE CHAS", hasTransfer: true, transferCityTitle: "MOSKVA", timeOfDay: .day))
}
