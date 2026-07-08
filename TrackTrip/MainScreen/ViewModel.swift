
import Foundation
import Combine

final class ViewModel: ObservableObject {
    @Published var fromCity: String = ""
    @Published var toCity: String = ""
    
    @Published var path: [Route] = []
    
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
    
    func didSelectCity(_ city: String, for field: CityField) {
        switch field {
        case .from:
            fromCity = city
        case .to:
            toCity = city
        }
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func didSelectStation(_ station: String, in city: City, for field: CityField) {
        let displayText = "\(city.name), \(station)"
        fromCity = displayText
        path.removeAll()
    }
    
    func search() {
        
    }
}
