
import Foundation
import OpenAPIURLSession

final class YandexScheduleManager {
    private let apiKey: String
    private let client: Client
    
    init(apiKey: String) throws {
        self.apiKey = apiKey
        self.client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport())
    }
    
    func testFetchStations() async throws -> NearestStations {
        let service = NearestStationsService(apiKey: apiKey, client: client)
        return try await service.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
    }
    
    func testFetchCopyright() async throws -> Copyright {
        let service = CopyrightService(apiKey: apiKey, client: client)
        return try await service.getCopyright()
    }
    
    func testFetchAllStation() async throws -> AllStations {
        let service = AllStationsService(apiKey: apiKey, client: client)
        return try await service.getAllStations()
    }
    
    func testCarrier() async throws -> Carrier {
        let service = CarrierService(apiKey: apiKey, client: client)
        return try await service.getCarrierInfo(code: "26")
    }
    
    func testNearestCity() async throws -> NearestCity {
        let service = NearestCityService(apiKey: apiKey, client: client)
        return try await service.getNearestCity(lat: 55.7558, lng: 37.6173)
    }
    
    func testScheduleAtStation() async throws -> ScheduleAtStation {
        let service = ScheduleAtStationService(apiKey: apiKey, client: client)
        return try await service.getStationSchedule(station: "s9600213")
    }
    
    func testScheduleBetweenStations() async throws -> ScheduleBetweenStations {
        let service = ScheduleBetweenStationsService(apiKey: apiKey, client: client)
        return try await service.getSchedualBetweenStations(from: "s9600396", to: "s9600213", transfers: false)
    }
    
    func testThread() async throws -> StationThread {
        let service = StationThreadService(apiKey: apiKey, client: client)
        return try await service.getRouteStations(uid: "SU-424_261025_c26_12")
    }
}
