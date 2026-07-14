
import Foundation
import Combine

final class ViewModel: ObservableObject {
    @Published var fromCity: String = ""
    @Published var toCity: String = ""
    
    @Published private(set) var fromStation: Station?
    @Published private(set) var toStation: Station?
    
    @Published var path: [Route] = []
    
    var isSearchShown: Bool {
        !fromCity.isEmpty && !toCity.isEmpty
    }
    
    func SwapCities() {
        let tempCity = fromCity
        let tempStation = fromStation
        fromCity = toCity
        toCity = tempCity
        fromStation = toStation
        toStation = tempStation
    }
    
    func selectFrom() {
        path.append(.citySelection(field: .from))
    }
    
    func selectTo() {
        path.append(.citySelection(field: .to))
    }
    
    func didSelectCity(for field: CityField,_ city: City) {
        switch field {
        case .from:
            fromCity = city.name
        case .to:
            toCity = city.name
        }
        path.append(.stationSelection(field: field, city: city))
    }
    
    func didSelectStation(for field: CityField, in city: City, _ station: Station) {
        let displayText = "\(station.title)"

        switch field {
        case .from:
            fromCity = displayText
            fromStation = station
        case .to:
            toCity = displayText
            toStation = station
        }
        path.removeAll()
    }
    
    func search() {
        guard let fromStation, let toStation else { return }
        path.append(.carrierList(from: fromStation, to: toStation, fromTitle: fromCity, toTitle: toCity))
    }
}
