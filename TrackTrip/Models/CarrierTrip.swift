

import Foundation

struct CarrierTrip: Identifiable, Hashable {
    let id: String
    let carrierTitle: String
    let carrierCode: Int?
    let carrierLogoURL: URL?
    let dateText: String
    let departureTime: String
    let arrivalTime: String
    let durationText: String
    let hasTransfer: Bool
    let transferCityTitle: String?
    let timeOfDay: TimeOfDay
}
