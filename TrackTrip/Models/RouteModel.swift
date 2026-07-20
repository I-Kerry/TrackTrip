
import Foundation

enum CityField: Hashable {
    case from
    case to
    
    var title: String {
        switch self {
        case .from:
            return "Откуда"
        case .to:
            return "Куда"
        }
    }
}

enum Route: Hashable {
    case citySelection(field: CityField)
    case stationSelection(field: CityField, city: City)
    case carrierList(from: Station, to: Station, fromTitle: String, toTitle: String)
}
