
import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleBetweenStations = Components.Schemas.Segments

protocol ScheduleBetweenStationsProtocol {
    func getSchedualBetweenStations(from: String, to: String, transfers: Bool?) async throws -> ScheduleBetweenStations
}

final class ScheduleBetweenStationsService: BaseService, ScheduleBetweenStationsProtocol {

    func getSchedualBetweenStations(from: String, to: String, transfers: Bool?) async throws -> ScheduleBetweenStations {
        let response = try await client.getSchedualBetweenStations(query: .init(
            apikey: apiKey,
            from: from,
            to: to,
            transfers: transfers))
        return try response.ok.body.json
    }
}
