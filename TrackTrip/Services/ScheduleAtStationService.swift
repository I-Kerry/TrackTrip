
import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleAtStation = Components.Schemas.ScheduleResponse

protocol ScheduleAtStationProtocol {
    func getStationSchedule(station: String) async throws -> ScheduleAtStation
}

final class ScheduleAtStationService: ScheduleAtStationProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getStationSchedule(station: String) async throws -> ScheduleAtStation {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apiKey,
            station: station))
                
        return try response.ok.body.json
    }
}
