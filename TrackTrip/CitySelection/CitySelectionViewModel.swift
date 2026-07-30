import Foundation
import Combine

@MainActor
final class CitySelectionViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published private var cities: [City] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var error: AppError?
    
    private static var cachedCities: [City]?
    private static var ongoingTask: Task<[City], Error>?
    
    private let stationService: AllStationsProtocol
    
    init(stationService: AllStationsProtocol = Services.allStations) {
        self.stationService = stationService
    }
    
    var filteredCities: [City]  {
        guard !searchText.isEmpty else { return cities }
        return cities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    func loadCities() async throws {
        print("cache:", Self.cachedCities?.count ?? -1)

        if let cached = Self.cachedCities {
            cities = cached
            return
        }
        
        if let task = Self.ongoingTask {
            cities = try await task.value
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        error = nil
        
        let task = Task<[City], Error> { [stationService] in
            let response = try await stationService.getAllStations()
            return CitySelectionViewModel.map(response)
        }
        
        Self.ongoingTask = task
        defer { Self.ongoingTask = nil }
        
        do {
            let result = try await task.value
            Self.cachedCities = result
            cities = result
        } catch {
            errorMessage = "Не удалось загрузить города"
            self.error = AppError.from(error)
        }
    }
    
    private static func map(_ response: AllStations) -> [City] {
        var result: [City] = []
        for country in response.countries ?? [] {
            for region in country.regions ?? [] {
                for settlement in region.settlements ?? [] {
                    
                    guard let name = settlement.title else { continue }
                    
                    var stations: [Station] = []
                    
                    for station in settlement.stations ?? [] {
                        guard let title = station.title else { continue }
                              
                        let code = station.code
                        ?? station.codes?.yandex_code
                        ?? station.codes?.esr_code
                        
                        guard let code else { continue }
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
