
import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleAtStation = Components.Schemas.ScheduleResponse

protocol ScheduleAtStationProtocol: Sendable {
    func getStationSchedule(station: String) async throws -> ScheduleAtStation
}

final class ScheduleAtStationService: BaseService, ScheduleAtStationProtocol, @unchecked Sendable {

    func getStationSchedule(station: String) async throws -> ScheduleAtStation {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apiKey,
            station: station))
                
        return try response.ok.body.json
    }
}
