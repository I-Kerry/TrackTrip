
import SwiftUI

struct CarrierListCell: View {
    let trip: CarrierTrip
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            header
            timeline
        }
        .padding(16)
        .background(.lightGrayBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
    
    private var header: some View {
        HStack {
            carrierLogo
            VStack(alignment: .leading, spacing: 2) {
                Text(trip.carrierTitle)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.black)
                if trip.hasTransfer {
                    Text(trip.transferCityTitle.map { "с пересадкой в \($0)" } ?? "с пересадкой")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.red)
                }
            }
            Spacer()
            Text(trip.dateText)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.black)
        }
    }
    
    private var timeline: some View {
        HStack(spacing: 8) {
            VStack(spacing: 4) {
                HStack(spacing: 2) {
                    Text(trip.departureTime)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.black)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.black)
                    Text(trip.durationText)
                        .font(.system(size: 12, weight: .regular))
                        .lineLimit(1)
                        .foregroundStyle(.black)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.black)
                    Text(trip.arrivalTime)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.black)
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
                .fill(Color.gray)
        }
        .frame(width: 38, height: 38)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    CarrierListCell(trip: CarrierTrip(
        id: "1",
        carrierTitle: "Гранд Сервис Экспресс (Таврия)", carrierCode: nil,
        carrierLogoURL: nil,
        dateText: "20 июля",
        departureTime: "14:30",
        arrivalTime: "09:15",
        durationText: "18 часов",
        hasTransfer: false,
        transferCityTitle: nil,
        timeOfDay: .day
    ))}
