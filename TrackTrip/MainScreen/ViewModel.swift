
import Foundation
import Combine

final class ViewModel: ObservableObject {
    @Published var fromCity: String = ""
    @Published var toCity: String = ""
    
    @Published var path: [Route] = []
    
    init() {
        print("MainScreenViewModel init", ObjectIdentifier(self))
    }
    
    var isSearchShown: Bool {
        !fromCity.isEmpty && !toCity.isEmpty
    }
    
    func SwapCities() {
        let temp = fromCity
        fromCity = toCity
        toCity = temp
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
//        if !path.isEmpty {
//            path.removeLast()
//        }
        path.append(.stationSelection(field: field, city: city))
    }
    
    func didSelectStation(for field: CityField, in city: City, _ station: Station) {
        let displayText = "\(city.name) (\(station.title))"
        switch field {
        case .from:
            fromCity = displayText
        case .to:
            toCity = displayText
        }
        path.removeAll()
    }
    
    func search() {
        
    }
}
