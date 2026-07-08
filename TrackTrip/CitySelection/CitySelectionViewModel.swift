import Foundation
import Combine

final class CitySelectionViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published private var cities: [City] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let stationService: AllStationsProtocol
    
    init(stationService: AllStationsProtocol = AllStationsService(apiKey: ApiKey.apikey, client: APIClient.shared)) {
        self.stationService = stationService
    }
    
    var filteredCities: [City]  {
        guard !searchText.isEmpty else { return cities }
        return cities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    func loadCities() async throws {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await stationService.getAllStations()
            cities = map(response)
        } catch {
            errorMessage = "Не удалось загрузить города"
        }
    }
    
    private func map(_ response: AllStations) -> [City] {
        var result: [City] = []
        for country in response.countries ?? [] {
            for region in country.regions ?? [] {
                for settlement in region.settlements ?? [] {
                    
                    guard let name = settlement.title else { continue }
                    var stations: [Station] = []
                    
                    for station in settlement.stations ?? [] {
                        guard let title = station.title,
                              let code = station.code else { continue }
                        stations.append(Station(id: code, title: title, code: code))
                    }
                    let id = settlement.codes?.yandex_code ?? name
                    
                    result.append(City(id: id, name: name, station: stations))
                }
            }
        }
        return result
    }
}
